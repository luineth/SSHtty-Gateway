FROM alpine:latest

RUN apk add --no-cache \
	busybox-extras \
	dropbear-dbclient \
	ca-certificates

RUN adduser -D -h /home/gateway gateway

COPY entrypoint.awk /entrypoint.awk
RUN chmod +x /entrypoint.awk



RUN mkdir -p /home/gateway/.ssh \
	&& chmod 700 /home/gateway/.ssh \
	&& chown -R gateway:gateway /home/gateway

USER gateway
WORKDIR /home/gateway

EXPOSE 2323

CMD ["/usr/sbin/telnetd", "-F", "-p", "2323", "-l", "/entrypoint.awk"]
