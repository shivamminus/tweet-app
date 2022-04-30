from flask import Flask, request, jsonify


from flask import Flask
from flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)
app.config['SECRET_KEY'] = '4YrzfpQ4kGXjuP6w'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] =False
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://myrootuser:password123@localhost:3306/twitter'
db = SQLAlchemy(app)

import routes


if __name__ == '__main__':
    app.run(debug = True, host="127.0.0.1",port=5000)