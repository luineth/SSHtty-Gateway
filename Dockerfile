FROM alpine:latest

RUN apk add --no-cache \
	busybox-extras \
	dropbear-dbclient \
	ca-certificates

COPY entrypoint.awk /entrypoint.awk
RUN chmod +x /entrypoint.awk

RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

EXPOSE 23

CMD ["/usr/sbin/telnetd", "-F", "-l", "/entrypoint.awk"]
