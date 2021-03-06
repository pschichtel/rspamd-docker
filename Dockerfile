# This Dockerfile is losely based on the rspamd's own Dockerfile

FROM debian:buster-slim

LABEL maintainer="Phillip Schichtel <phillip@schich.tel>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get install --no-install-recommends -y gnupg ca-certificates \
 && apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 3FA347D5E599BE4595CA2576FFA232EDBF21E25E \
 && echo "deb http://rspamd.com/apt-stable/ buster main" > /etc/apt/sources.list.d/rspamd.list \
 && apt-get purge -y gnupg \
 && apt-get autoremove --purge -y \
 && apt-get update

RUN apt-get --no-install-recommends install -y rspamd

COPY --chown=_rspamd:_rspamd overrides/* /etc/rspamd/override.d/

VOLUME ["/var/lib/rspamd", "/etc/rspamd/local.d"]

EXPOSE 11332 11333 11334

ENTRYPOINT ["rspamd", "-f", "-u", "_rspamd", "-g", "_rspamd"]

