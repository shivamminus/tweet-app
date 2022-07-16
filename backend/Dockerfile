FROM python:bullseye

WORKDIR /flaskapp

COPY requirements.txt requirements.txt

RUN python3 -m pip install --no-cache-dir -r requirements.txt

COPY . .


EXPOSE 5000

CMD [ "python3", "app.py"]