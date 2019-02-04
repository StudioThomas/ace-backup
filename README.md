# ace-backup

Dockerized, automated, remote backup utility for ACE projects

### Run container with required permissions for mounting sshfs volume

    docker run \
      -d \
      -it \
      --name ace-backup \
      --env-file=.env \
      --cap-add SYS_ADMIN --device=/dev/fuse --security-opt apparmor:unconfined \
      homerjam/ace-backup

### Run container with local volume

    docker run \
      -d \
      -it \
      --name ace-backup \
      --env-file=.env \
      -v /vol:/mnt/assist \
      homerjam/ace-backup

### Example .env file

    AWS_ACCESS_KEY_ID=
    AWS_SECRET_ACCESS_KEY=
    AWS_DEFAULT_REGION=
    AWS_BUCKET=

    # required for assist backup
    ASSIST_VOLUME=/mnt/assist

    # optional
    ASSIST_REMOTE_USERNAME=
    ASSIST_REMOTE_PASSWORD=
    ASSIST_REMOTE_HOST=

    # required for couch backup
    COUCH_URL=

    BACKUP_MINUTE=0
    BACKUP_HOUR=0

### Required settings on remote for mounting sshfs volume in docker

    # /etc/ssh/sshd_config
    PermitRootLogin yes
    PasswordAuthentication yes

### Useful

    # build image
    $ docker build -t homerjam/ace-backup .

    # ssh into running container
    $ docker exec -it ace-backup bash
