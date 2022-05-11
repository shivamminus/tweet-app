from flask import Flask, request, jsonify


from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS


app = Flask(__name__)
app.config['SECRET_KEY'] = '4YrzfpQ4kGXjuP6w'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] =False
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://myrootuser:password123@localhost:3306/twitter'
db = SQLAlchemy(app)


import socket

# IMPLEMENTING PROMETHEUS
import time

from prometheus_client import Counter, Histogram
from prometheus_client import start_http_server
from flask import request
from prometheus_flask_exporter import PrometheusMetrics
from prometheus_client import CollectorRegistry
metrics = PrometheusMetrics(app, registry=CollectorRegistry(auto_describe=False),export_defaults=False)

FLASK_REQUEST_LATENCY = Histogram('flask_request_latency_seconds', 'Flask Request Latency',	['method', 'endpoint'])
FLASK_REQUEST_COUNT = Counter('flask_request_count', 'Flask Request Count',	['method', 'endpoint', 'http_status'])

from prometheus_client import REGISTRY, PROCESS_COLLECTOR, PLATFORM_COLLECTOR




if __name__ == '__main__':
    # monitor(app, port=8000)

    def before_request():
        request.start_time = time.time()


    def after_request(response):
        request_latency = time.time() - request.start_time
        FLASK_REQUEST_LATENCY.labels(request.method, request.path).observe(request_latency)
        FLASK_REQUEST_COUNT.labels(request.method, request.path, response.status_code).inc()

        return response


    def monitor(app, port=8000, addr=''):
        app.before_request(before_request)
        app.after_request(after_request)
        start_http_server(port, addr) 


    from flask_prom import monitor


    app.config.update({
    'OIDC_CLIENT_SECRETS': './../../../../client_secrets.json',
    'OIDC_RESOURCE_SERVER_ONLY': True
    })
    # oidc = OpenIDConnect(app)
    CORS(app)
    monitor(app, path="/metrics", http_server=True, port=9090, addr="127.0.0.1")
    import routes
    import modals
    try:
        print("Creating DB.. if not exiisting",db)
        # db.drop_all()
        db.create_all()
    except Exception as e:
        print("DB is not created!", e)
    app.run(debug = True, host="127.0.0.1",port=5000)