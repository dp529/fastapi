ARG BASE_IMAGE=python
ARG UBUNTU_VERSION=3.12-slim
FROM ${BASE_IMAGE}:${UBUNTU_VERSION}
LABEL author="Dileep Mundluri" email="dp@gmail.com"
ARG PACKAGE_VERSION=1.15.4
WORKDIR /app
RUN apt update && apt install -y python3-pip jq net-tools tree unzip
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
ADD templates templates
ADD routers routers
ADD https://releases.hashicorp.com/terraform/${PACKAGE_VERSION}/terraform_${PACKAGE_VERSION}_linux_amd64.zip unzip.zip
RUN unzip unzip.zip -d /usr/local/bin/ && rm unzip.zip

COPY main.py main.py
RUN apt-get update && \
    apt-get remove -y python3-pip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
    rm -rf *.zip
EXPOSE 80
ENTRYPOINT ["uvicorn", "main:app", "--host", "0.0.0.0"]
CMD ["--port", "80"]

#This updated Dockerfile has reduced container image from 1.69GB to 966MB.

