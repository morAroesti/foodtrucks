FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python2.7 \
    curl \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py \
    && python2.7 get-pip.py \
    && rm get-pip.py

WORKDIR /app

COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh
COPY flask-app ./flask-app
COPY flask-app/static ./static



COPY flask-app/requirements.txt ./
RUN pip install -r requirements.txt

COPY flask-app/package*.json ./
RUN npm install

# Expose Port
EXPOSE 5000

# Start application
ENTRYPOINT ["./entrypoint.sh"]