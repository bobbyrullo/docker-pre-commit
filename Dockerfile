FROM ubuntu:xenial
MAINTAINER Jamie Alessio <jamie@calthorpeanalytics.com>

RUN apt-get update && apt-get install -y \
      build-essential \
      git \
      libxml2-dev \
      libxslt1-dev \
      nodejs \
      python-dev \
      python-pip \
      ruby \
      zlib1g-dev

RUN pip install pre-commit

RUN mkdir /pre-commit
COPY .pre-commit-config-for-build.yaml /pre-commit/.pre-commit-config.yaml

# Use pre-generated .pre-commit-config.yaml to run pre-commit python
# executable so all dependencies are automatically installed in image.
RUN cd /pre-commit && \
      git init . && \
      cat .pre-commit-config.yaml && \
      pre-commit run

ENTRYPOINT ["pre-commit"]
