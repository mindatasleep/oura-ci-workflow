# @current_user.create_oura!(userinfo: {'newinfo':1})
require 'oauth2'
require 'faraday'
require 'faraday_middleware'

class OurasController < ApplicationController
  before_action :set_oura, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :at_least_one_exists, only: [:index]

  # GET /ouras
  # GET /ouras.json
  def index
    @ouras = Oura.all
  end

  # GET /ouras/1
  # GET /ouras/1.json
  def show
  end

  # GET /ouras/new
  def new
    @oura = current_user.create_oura!(
      userinfo: {},
      sleep: {},
      activity: {},
      readiness: {}
    )
  end

  # GET /ouras/1/edit
  def edit

    oura_cloud_request_all_data

    respond_to do |format|

      if @oura = current_user.create_oura!(
                    userinfo: @userinfo.body,
                    sleep: @sleep.body,
                    activity: @activity.body,
                    readiness: @readiness.body
                  )

        format.html { redirect_to @oura, notice: 'Oura was successfully updated.' }
        format.json { render :show, status: :ok, location: @oura }
      else
        format.html { render :edit }
        format.json { render json: @oura.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /ouras
  # POST /ouras.json
  def create
    @oura = current_user.create_oura!(oura_params)

    respond_to do |format|
      if @oura.save
        format.html { redirect_to @oura, notice: 'Oura was successfully created.' }
        format.json { render :show, status: :created, location: @oura }
      else
        format.html { render :new }
        format.json { render json: @oura.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ouras/1
  # PATCH/PUT /ouras/1.json
  def update

    respond_to do |format|
      if @oura = current_user.create_oura!(oura_params)
        format.html { redirect_to @oura, notice: 'Oura was successfully updated.' }
        format.json { render :show, status: :ok, location: @oura }
      else
        format.html { render :edit }
        format.json { render json: @oura.errors, status: :unprocessable_entity }
      end
    end

    # redirect_to ouras_url

  end

  # DELETE /ouras/1
  # DELETE /ouras/1.json
  def destroy
    @oura.destroy
    respond_to do |format|
      format.html { redirect_to ouras_url, notice: 'Oura was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def oura_cloud_authorization
    # Todo: secure secret parameters
    app_id = "H73PB6RSNZ3DA5KB"
    secret = "QW6EB6FNJFPG4MHTAA4SDI22IYHSSRSK"
    callback_url = "http://0.0.0.0:3000/oura/callback"
    client = OAuth2::Client.new(app_id, secret, site: "https://cloud.ouraring.com/oauth/authorize")
    authorize_url = client.auth_code.authorize_url(redirect_uri: callback_url, response_type: "code")
    redirect_to authorize_url
  end


  def callback
    callback_url = "http://0.0.0.0:3000/oura/callback"

    app_id = "H73PB6RSNZ3DA5KB"
    secret = "QW6EB6FNJFPG4MHTAA4SDI22IYHSSRSK"

    con = Faraday.new 
    response = con.post('https://api.ouraring.com/oauth/token') do |req|
      req.params['code'] = params[:code] 
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = callback_url
      req.params['client_id'] = app_id
      req.params['client_secret'] = secret
    end

    session[:access_token] = JSON.parse(response.body)["access_token"]
    session[:refresh_token] = JSON.parse(response.body)["refresh_token"]

    # current_user.oura.access_token = session[:access_token]
    # current_user.oura.refresh_token = session[:refresh_token]

    redirect_to edit_oura_path(current_user.oura.id)
    
  end

  private
  # Private actions are those not exposed to the browser.
    # Use callbacks to share common setup or constraints between actions.
    def set_oura
      @oura = Oura.find(current_user.oura.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def oura_params
      params.require(:oura).permit(:user_id, :userinfo, :sleep, :activity, :readiness)
    end

    def at_least_one_exists
      @oura = Oura.first_or_create(user_id: current_user.id)
    end

    def oura_cloud_request_token
    end

    def oura_cloud_request_all_data

      puts "Start: oura_cloud_request_all_data"

      @userinfo = Faraday.get('https://api.ouraring.com/v1/userinfo') do |req|
        req.params['access_token'] = session[:access_token]
      end
  
      @sleep = Faraday.get('https://api.ouraring.com/v1/sleep') do |req|
        req.params['start'] = "2020-01-01"
        req.params['end'] = "2020-01-04"
        req.params['access_token'] = session[:access_token]
      end
  
      @activity = Faraday.get('https://api.ouraring.com/v1/activity') do |req|
        req.params['start'] = "2020-01-01"
        req.params['end'] = "2020-01-04"
        req.params['access_token'] = session[:access_token]
      end
  
      @readiness = Faraday.get('https://api.ouraring.com/v1/readiness') do |req|
        req.params['start'] = "2020-01-01"
        req.params['end'] = "2020-01-04"
        req.params['access_token'] = session[:access_token]
      end

      puts @readiness.body
      puts "Complete: oura_cloud_request_all_data"
    
    end
end
