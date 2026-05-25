ARG BASE_IMAGE=python
ARG UBUNTU_VERSION=3.12-slim
FROM ${BASE_IMAGE}:${UBUNTU_VERSION}
LABEL author="Sreeharsha Veerapalli" email="demouser@gmail.com"
WORKDIR /app
RUN apt-get update && \
    apt-get install -y --no-install-recommends jq net-tools tree unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
COPY templates templates
COPY routers routers
COPY main.py main.py
EXPOSE 80
ENTRYPOINT ["uvicorn", "main:app", "--host", "0.0.0.0"]
CMD ["--port", "80"]

#This updated Dockerfile has reduced container image from 1.69GB to 966MB.

