FROM alpine:latest
MAINTAINER Lars Kiesow <lkiesow@uos.de>
RUN mkdir -p /data /conf /etc/ssh/authorized_keys
RUN apk --no-cache add rssh

ADD sshd_config /etc/ssh/sshd_config
ADD rssh.conf /etc/rssh.conf
ADD run.sh /

EXPOSE 22
CMD /run.sh
