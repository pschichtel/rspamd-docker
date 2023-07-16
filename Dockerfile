# This Dockerfile is losely based on the rspamd's own Dockerfile

ARG DEBIAN_CODENAME="bookworm"

FROM debian:${DEBIAN_CODENAME}-slim

ARG DEBIAN_CODENAME

LABEL maintainer="Phillip Schichtel <phillip@schich.tel>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get install --no-install-recommends -y curl gnupg ca-certificates \
 && curl -fsSL "https://rspamd.com/apt-stable/gpg.key" | gpg --batch --yes --dearmor -o "/usr/share/keyrings/rspamd.gpg" \
 && echo "deb [signed-by=/usr/share/keyrings/rspamd.gpg] http://rspamd.com/apt-stable/ ${DEBIAN_CODENAME} main" > /etc/apt/sources.list.d/rspamd.list \
 && apt-get purge -y gnupg curl \
 && apt-get autoremove --purge -y \
 && apt-get update

RUN apt-get --no-install-recommends install -y rspamd

COPY --chown=_rspamd:_rspamd overrides/* /etc/rspamd/override.d/

VOLUME ["/var/lib/rspamd", "/etc/rspamd/local.d"]

EXPOSE 11332 11333 11334

ENTRYPOINT ["rspamd", "-f", "-u", "_rspamd", "-g", "_rspamd"]

