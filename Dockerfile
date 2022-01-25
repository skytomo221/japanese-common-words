ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    mecab \
    libmecab-dev \
    mecab-ipadic-utf8 \
    git \
    make \
    curl \
    xz-utils \
    file \
    patch

RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
    cd mecab-ipadic-neologd && \
    bin/install-mecab-ipadic-neologd -n -y && \
    cd .. && \
    rm -r mecab-ipadic-neologd

USER ${NB_UID}

RUN pip install \
    autopep8 \
    mecab-python3 \
    nltk \
    unidic-lite

WORKDIR "${HOME}"
