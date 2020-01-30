FROM python:3.8-slim
LABEL maintainer="pgzmnk"

RUN apt-get update -y && apt-get install -y python-pip python-dev

ADD requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt
WORKDIR /myapp
COPY /src/ /myapp/src/

# ENTRYPOINT ["python3", "-u", "-m", "src.studies.iris", "src/data/", "src/tmp/plot1.png"]
ENTRYPOINT ["python3", "-m", "src.studies.vega_test", "src/data/", "src/tmp/partials/_vega.html"]
# Todo: edit so output path is given as an argument to the entrypoint
