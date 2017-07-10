FROM ubuntu:16.04

RUN apt-get update && \
    apt-get upgrade -y

# Install dependencies
RUN apt-get install -y \
    supervisor \
    sshfs \
    cron \
    less \
    man \
    ssh \
    python \
    python-pip

# Install AWS CLI
RUN pip install awscli

# Add supervisor configuration
RUN mkdir -p /var/log/supervisor
ADD scripts/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add scripts
COPY scripts /scripts

# Make scripts executable
RUN chmod +x /scripts/assist.sh

# Make mount point
RUN mkdir /mnt/assist

WORKDIR /mnt/assist

CMD ["/usr/bin/supervisord"]
