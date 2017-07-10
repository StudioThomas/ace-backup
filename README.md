# ace-backup

Dockerized, automated, remote backup utility for ACE projects

### Run container with required permissions for mounting sshfs volume

    docker run \
      -d \
      -it \
      --name ace-backup \
      --env-file=.env \
      --cap-add SYS_ADMIN --device=/dev/fuse --security-opt apparmor:unconfined \
      studiothomas/ace-backup

### Run container with local volume

    docker run \
      -d \
      -it \
      --name ace-backup \
      --env-file=.env \
      -v /vol:/mnt/assist \
      studiothomas/ace-backup

### Example .env file

    AWS_ACCESS_KEY_ID=
    AWS_SECRET_ACCESS_KEY=
    AWS_DEFAULT_REGION=eu-west-1
    AWS_BUCKET=

    # Optional
    ASSIST_REMOTE_USERNAME=
    ASSIST_REMOTE_PASSWORD=
    ASSIST_REMOTE_HOST=

    COUCH_URL=

### Required settings on remote for mounting sshfs volume in docker

    # /etc/ssh/sshd_config
    PermitRootLogin yes
    PasswordAuthentication yes