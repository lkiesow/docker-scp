FROM alpine:latest
MAINTAINER Lars Kiesow <lkiesow@uos.de>
RUN apk --update add rssh
COPY sshd_config /etc/ssh/sshd_config
COPY rssh.conf /etc/rssh.conf
RUN adduser -D -s /usr/bin/rssh -h /data deploy
RUN passwd -u deploy

ADD run.sh /
EXPOSE 22
CMD /run.sh
