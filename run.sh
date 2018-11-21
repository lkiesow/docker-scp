#!/bin/sh

set -ue

if [ -n "${DEPLOY_KEY+x}" ]; then
  echo "${DEPLOY_KEY}" > "/conf/${DEPLOY_USER:-deploy}"
fi

# remove old keys
rm -f /etc/ssh/authorized_keys/* || :

# add new users and keys
cd /conf
for user in *; do
  if ! id -u "${user}"; then
    adduser -D -s /usr/bin/rssh -h "/data/${user}" "${user}"
    passwd -u "${user}"
  fi
  install -m 400 -o "${user}" "${user}" /etc/ssh/authorized_keys/
done

if [ ! -f /etc/ssh/ssh_host_ed25519_key ]; then
  ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
fi

/usr/sbin/sshd -D -e -h /etc/ssh/ssh_host_ed25519_key
