import os

from flask import Flask, request, redirect, session, url_for, render_template
from requests_oauthlib import OAuth2Session
import requests
import pandas as pd
import altair as alt


CLIENT_ID = 'H73PB6RSNZ3DA5KB'
CLIENT_SECRET = 'QW6EB6FNJFPG4MHTAA4SDI22IYHSSRSK'
AUTH_URL = 'https://cloud.ouraring.com/oauth/authorize'
TOKEN_URL = 'https://api.ouraring.com/oauth/token'

OUTPUT_PATH = 'output/'
TEMPLATES_PATH = 'templates/'

app = Flask(__name__)


@app.route('/plot')
@app.route('/plot/<summary>/<varnames>')
def plot(summary='sleep', varnames='rmssd'):
    """Use the Altair library to plot the data indicated by the parsed URL
    parameters.

    <summary> : data category from the summaries list
    <varnames> : column names from csv, separated by a (space) in the URL

    e.g. http://0.0.0.0:3030/plot/sleep/rmssd
    """

    CHART_NAME = 'plot1.html'

    # Read CSV for selected summary
    df = pd.read_csv(
        OUTPUT_PATH + summary + '.csv',
        index_col='summary_date',
        parse_dates=True)[varnames.split(' ')]

    # Create source data structure for Altair plot
    source = df.reset_index().melt('summary_date')

    # Create Altair Chart object
    chart = alt.Chart(source).mark_line().encode(
        x='summary_date:T',
        y='value:Q',
        color='variable',
    ).properties(width=600, height=400)

    # Save chart
    chart.save(TEMPLATES_PATH + CHART_NAME)

    return render_template(CHART_NAME)


@app.route('/summaries')
def summaries():
    """Request data for sleep, activity, and readiness summaries. Save to CSV.
    """
    # Request data
    oauth_token = session['oauth']['access_token']
    summaries = ['sleep', 'activity', 'readiness']

    # Loop through summary types
    for summary in summaries:
        url = 'https://api.ouraring.com/v1/' + summary + '?start=2018-01-01'

        result = requests.get(url, headers={'Content-Type': 'application/json',
                                            'Authorization': 'Bearer {}'
                                            .format(oauth_token)})

        # Convert response JSON to DataFrame
        df = pd.DataFrame(result.json()[summary])
        # Write CSV to output path
        df.to_csv(OUTPUT_PATH + summary + '.csv')

    return '<h1>Successfully requested summary data.</h1>'


@app.route('/')
def index():
    """Home page.
    """
    return '<h1>Home page.</h1>'


@app.route('/oura_login')
def oura_login():
    """Redirect to the OAuth provider login page.
    """

    oura_session = OAuth2Session(CLIENT_ID)

    # URL for Oura's authorization page.
    authorization_url, state = oura_session.authorization_url(AUTH_URL)
    session['oauth_state'] = state
    return redirect(authorization_url)


@app.route('/callback')
def callback():
    """Retrieve acces_token from Oura response URL. Redirect to profile page.
    """

    oura_session = OAuth2Session(CLIENT_ID, state=session['oauth_state'])
    session['oauth'] = oura_session.fetch_token(
                        TOKEN_URL,
                        client_secret=CLIENT_SECRET,
                        authorization_response=request.url)

    return redirect(url_for('.profile'))


@app.route('/profile')
def profile():
    """User profile.
    """
    oauth_token = session['oauth']['access_token']
    result = requests.get('https://api.ouraring.com/v1/userinfo?access_token=' + oauth_token)
    return str(result.json()) 


if __name__ == '__main__':

    os.environ['OAUTHLIB_INSECURE_TRANSPORT'] = '1'
    app.secret_key = os.urandom(24)
    app.config['TEMPLATES_AUTO_RELOAD'] = True
    app.run(debug=False, host='0.0.0.0', port=3030)