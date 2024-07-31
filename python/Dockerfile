FROM rockylinux:8 as base

# Set the environment variable for PyPI index URL and PYTHON
ARG PIP_INDEX_URL
ARG PYTHON
ENV PIP_INDEX_URL=${PIP_INDEX_URL}
ENV PYTHON=${PYTHON}

RUN yum -y upgrade && \
    yum -y install epel-release && \ 
    yum -y install supervisor git gcc gcc-c++ zip unzip openssh-server wget tar make && \
    yum -y install openssl-devel bzip2-devel libffi-devel
    
ADD .ssh /root/.ssh
RUN chmod 600 /root/.ssh/* && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN yum -y install python3.12 python3.12-pip python3.12-devel libxml2-devel libxslt-devel freetype-devel

### START NEW IMAGE: DEBUGGER ###
FROM base as debug

ADD debugpy.ini /etc/supervisord.d/debugpy.ini
COPY requirements.txt /tmp/requirements.txt

RUN chmod 755 /etc/supervisord.d/debugpy.ini

RUN $PYTHON -m venv /var/$PYTHON/silvaengine/env && \
    source /var/$PYTHON/silvaengine/env/bin/activate && \
    pip install pip -U -i "$PIP_INDEX_URL" && \
    pip install debugpy -i "$PIP_INDEX_URL" && \
    pip install -r /tmp/requirements.txt -i "$PIP_INDEX_URL"

WORKDIR /var/www/projects
