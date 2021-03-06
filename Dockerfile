FROM ubuntu:16.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

# Specify node version
RUN apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Install dependencies
RUN apt-get install -y \
    supervisor \
    sshfs \
    cron \
    gettext \
    jq \
    less \
    man \
    ssh \
    python \
    python-pip \
    nodejs

# Install AWS CLI
RUN pip install awscli

# Install couchbackup
RUN npm i -g @cloudant/couchbackup

# Add supervisor configuration
RUN mkdir -p /var/log/supervisor
ADD scripts/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add scripts
COPY scripts /scripts

# Make scripts executable
RUN chmod -R +x /scripts

# Make couch backup dir
RUN mkdir /root/couch

CMD /scripts/init.sh && /usr/bin/supervisord
