FROM rockylinux:8 as base

# Set the environment variable for PyPI index URL
ARG PIP_INDEX_URL
ENV PIP_INDEX_URL=${PIP_INDEX_URL}

RUN yum -y upgrade && \
    yum -y install epel-release && \ 
    yum -y install supervisor git gcc gcc-c++ zip unzip openssh-server wget tar make && \
    yum -y install openssl-devel bzip2-devel libffi-devel && \
    yum -y install python3.12-devel libxml2-devel libxslt-devel freetype-devel
    
ADD .ssh /root/.ssh
RUN chmod 600 /root/.ssh/* && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

ADD debugpy.ini /etc/supervisord.d/debugpy.ini
COPY requirements.txt /tmp/requirements.txt

RUN chmod 755 /etc/supervisord.d/debugpy.ini
RUN yum -y install python3.12 python3.12-pip
RUN pip3.12 install pip -U -i "$PIP_INDEX_URL" && \
    pip3.12 install -r /tmp/requirements.txt -i "$PIP_INDEX_URL"

### START NEW IMAGE: DEBUGGER ###
FROM base as debug

RUN pip3.12 install debugpy -i "$PIP_INDEX_URL"

RUN python3.12 -m venv /var/python3.12/silvaengine/env && \
    source /var/python3.12/silvaengine/env/bin/activate && \
    pip3.12 install pip -U -i "$PIP_INDEX_URL" && \
    pip3.12 install -r /tmp/requirements.txt -i "$PIP_INDEX_URL"

WORKDIR /var/www/projects
