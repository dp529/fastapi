ARG BASE_IMAGE=python
ARG UBUNTU_VERSION=3.12-slim
FROM ${BASE_IMAGE}:${UBUNTU_VERSION}

LABEL author="Dileep Mundluri" email="demouser@gmail.com"

WORKDIR /app

# Clean up apt lists immediately inside the same layer so they never save
RUN apt-get update && apt-get install -y --no-install-recommends \
    jq net-tools tree unzip \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

ADD templates templates
ADD routers routers
COPY main.py main.py

EXPOSE 80
ENTRYPOINT ["uvicorn", "main:app", "--host", "0.0.0.0"]
CMD ["--port", "80"]
