FROM almalinux/10-base as base

# Set the environment variable for PyPI index URL and PYTHON
ARG PIP_INDEX_URL
ARG PYTHON=python3
ENV PIP_INDEX_URL=${PIP_INDEX_URL}
ENV PYTHON=${PYTHON}

# Base OS packages
RUN dnf -y upgrade && \
    dnf -y install epel-release && \
    dnf -y install \
        supervisor \
        git \
        gcc \
        gcc-c++ \
        zip \
        unzip \
        openssh-server \
        wget \
        tar \
        make \
        openssl-devel \
        bzip2-devel \
        libffi-devel \
        libxml2-devel \
        libxslt-devel \
        freetype-devel \
        python3 \
        python3-pip \
        python3-devel && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# SSH keys (same as your original)
ADD .ssh /root/.ssh
RUN chmod 600 /root/.ssh/* && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

### START NEW IMAGE: DEBUGGER ###
FROM base as debug

ADD debugpy.ini /etc/supervisord.d/debugpy.ini
COPY requirements.txt /tmp/requirements.txt

RUN chmod 755 /etc/supervisord.d/debugpy.ini

RUN $PYTHON -m venv /var/$PYTHON/silvaengine/env && \
    source /var/$PYTHON/silvaengine/env/bin/activate && \
    pip install --upgrade pip -i "$PIP_INDEX_URL" && \
    pip install debugpy -i "$PIP_INDEX_URL" && \
    pip install -r /tmp/requirements.txt -i "$PIP_INDEX_URL"

WORKDIR /var/www/projects
