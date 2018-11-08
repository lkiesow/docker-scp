Docker SCP
==========

Docker container with OpenSSH and restricted shell via rssh to be used for
deploying files via scp.

```sh
ssh-keygen -t ed25519 -N '' -f id_ed2551
docker run -it \
  --name=deploy \
  -e "DEPLOY_KEY=$(cat id_ed25519.pub)" \
  quay.io/lkiesow/docker-scp
…
scp -i id_ed25519 file.xy deploy@172...:~
```
