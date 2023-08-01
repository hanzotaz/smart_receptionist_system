FROM python:3.8
WORKDIR /code
COPY ./requirements.txt /code/requirements.txt
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir --upgrade -r requirements.txt
COPY . /code/app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]