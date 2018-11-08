#!/bin/sh

set -ue

echo "${DEPLOY_KEY}" > /etc/ssh/authorized_keys
chown deploy:deploy /etc/ssh/authorized_keys
chmod 400 /etc/ssh/authorized_keys

if [ ! -f /etc/ssh/ssh_host_ed25519_key ]; then
  ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
fi

/usr/sbin/sshd -D
