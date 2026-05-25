# 1. Define clean base image arguments
ARG BASE_IMAGE=python
ARG TAG_VERSION=3.12-slim
FROM ${BASE_IMAGE}:${TAG_VERSION}

LABEL author="Dileep Mundluri" email="dp@gmail.com"

# Flexible Terraform versioning
ARG PACKAGE_VERSION=1.15.4

WORKDIR /app

# 2. Install basic system tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    jq net-tools tree unzip curl \
    && rm -rf /var/lib/apt/lists/*

# 3. Leverage layer caching for Python packages 
# (Note: python:3.12-slim already has pip; no need to apt install python3-pip)
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy app routers and views
COPY templates templates 
COPY routers routers

# 5. Download and extract Terraform cleanly using curl (replaces raw ADD)
RUN curl -sSL https://releases.hashicorp.com/terraform/${PACKAGE_VERSION}/terraform_${PACKAGE_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip -d /usr/local/bin/ \
    && rm terraform.zip

COPY main.py main.py

EXPOSE 80

ENTRYPOINT ["uvicorn", "main:app", "--host", "0.0.0.0"]
CMD ["--port", "80"]
