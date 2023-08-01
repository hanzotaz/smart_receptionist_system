FROM python:3.8-slim-bullseye
WORKDIR /flask-app
COPY ./requirements.txt /flask-app/requirements.txt
RUN apt update && apt install -y git ffmpeg
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir --upgrade -r requirements.txt
COPY . /flask-app
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "wsgi:app"]