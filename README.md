# tweet-app
This Repo contains the Backend API used in the Twiiter App for HackFSE1 Accreditation Prog for Python Domain.
# 
COMMANDS:
```
git clone https://github.com/shivamminus/tweet-app.git
pip install virtualenv
cd tweet-app
virtualenv venv
.\venv\bin\activate
pip install -r requirements.txt
python backend\app.py
```
# 

Once the Server is up, Note the directory of the log file generated.

For Prometheus, Visit localhost:5001/prometheus

Now to integrate the ELK Stack

Extract the 3 zips i.e. 
1. [elasticsearch-8.2.0-windows-x86_64.zip](https://www.elastic.co/downloads/elasticsearch)
2. [kibana-8.2.0-windows-x86_64.zip](https://www.elastic.co/downloads/kibana)
3. [logstash-8.2.0-windows-x86_64.zip](https://www.elastic.co/downloads/logstash)

#### TO CONFIGURE THE ELK STACK:

1. Go to elastic search bin directory and run the elasticsearch.bat file
2. For Kibana, first uncomment the host line in the config file for Kibana
3. For Logstash, make similar changes for the path file in the config folder.

For Reference: [Logstash Config](https://www.elastic.co/guide/en/logstash/8.1/configuration.html)
