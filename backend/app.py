from flask import Flask, request, jsonify


from flask import Flask
from flask_sqlalchemy import SQLAlchemy


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



# REGISTRY.unregister(PROCESS_COLLECTOR)
# REGISTRY.unregister(PLATFORM_COLLECTOR)
# # Unlike process and platform_collector gc_collector registers itself as three different collectors that have no corresponding public named variable. 
# REGISTRY.unregister(REGISTRY._names_to_collectors['python_gc_objects_collected_total'])
# REGISTRY.unregister(REGISTRY._names_to_collectors['python_gc_objects_uncollectable_total'])
# REGISTRY.unregister(REGISTRY._names_to_collectors['python_gc_collections_total'])

# [REGISTRY.unregister(c) for c in [PROCESS_COLLECTOR, PLATFORM_COLLECTOR, REGISTRY._names_to_collectors['python_gc_objects_collected_total', 'python_gc_objects_uncollectable_total'], REGISTRY._names_to_collectors['python_gc_uncollectable_objects_sum'], REGISTRY._names_to_collectors['python_gc_collected_objects_sum']]]

# collectors = list(REGISTRY._collector_to_names.keys())
# for collector in collectors:
    
#     if collector == 'histogram:flask_request_latency_seconds' or collector == 'count    er:flask_request_count':
#         print(collector)
#         pass
#     else:    
#         REGISTRY.unregister(collector)

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
    monitor(app, path="/metrics", http_server=True, port=9090, addr="127.0.0.1")
    import routes
    import modals
    try:
        print("Creating DB.. if not exiisting",db)
        # db.drop_all()
        db.create_all()
    except Exception as e:
        print("DB is not created!", e)
    app.run(debug = False, host="127.0.0.1",port=5000)