FROM alpine:3.9

RUN apk update \
 && apk add rspamd

ENTRYPOINT ["rspamd", "-f", "-u", "rspamd", "-g", "rspamd"]

