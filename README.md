Docker SCP
==========

Docker container with OpenSSH and restricted shell via rssh to be used for
deploying files via scp.


Configure Single User via Environment Variable
----------------------------------------------

```sh
ssh-keygen -t ed25519 -N '' -f id_ed2551
docker run -it \
  --name=deploy \
  -e DEPLOY_USER=deploy \
  -e "DEPLOY_KEY=$(cat id_ed25519.pub)" \
  quay.io/lkiesow/docker-scp
…
scp -i id_ed25519 file.xy deploy@172...:~
```

- `DEPLOY_USER` is optional and defaults to `deploy`
- If no `DEPLOY_KEY` is provided, this user is not created


Configure Users via Configuration Files
---------------------------------------

To configure an arbitrary amount of users, just provide their SSH key(s) in
`/conf/${username}`.

```sh
ssh-keygen -t ed25519 -N '' -f id_ed2551
cp id_ed2551.pub /path/on/host/config/user1
…
docker run -it \
  -p 2222:22 \
  --name=deploy \
  -v /path/on/host/config:/conf \
  quay.io/lkiesow/docker-scp
…
scp -i id_ed25519 file.xy deploy@172...:~

```

Multiple SSH Keys
-----------------

To allow access to one space using different keys, just add multiple keys to
the key file or the `DEPLOY_KEY` environment variable, one key per line.


Remove SSH Key
--------------

Using configuration files, just remove the offending key from the configuration
file and re-start the docker container.

If the key was added as environment variable, just start a new container with a
different environment variable using the same mounts.
