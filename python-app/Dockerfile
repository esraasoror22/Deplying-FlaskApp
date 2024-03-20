FROM python:3.9

WORKDIR /app

COPY requirements.txt /app/

RUN apt-get update &&\
    pip install -r requirements.txt

COPY . /app/

RUN pip3 install --upgrade Flask Werkzeug

# Expose the port the app runs on
EXPOSE 5000

# Define the command to run your Flask app
CMD ["python", "app.py"]

