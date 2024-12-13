#!/bin/sh
# Wait for Elasticsearch to be available
echo "Waiting for Elasticsearch to be available..."
until curl -s http://es:9200/; do
  sleep 5
done
echo "Elasticsearch is available. Starting the Flask app..."
chmod 777 flask-app/app.py
python2.7 flask-app/app.py