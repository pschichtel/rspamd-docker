FROM debian:stretch-slim

LABEL maintainer="Phillip Schichtel <phillip@schich.tel>"

# Set apt non-interactive
ENV DEBIAN_FRONTEND noninteractive

# Install Rspamd
RUN apt-get update \
 && apt-get --no-install-recommends install -y wget gnupg ca-certificates \
 && wget -O- https://rspamd.com/apt/gpg.key | apt-key add - \
 && echo "deb http://rspamd.com/apt/ stretch main" > /etc/apt/sources.list.d/rspamd.list \
 && apt-get purge -y wget gnupg \
 && apt-get autoremove --purge -y \
 && apt-get update

RUN apt-get --no-install-recommends install -y rspamd

ENTRYPOINT ["rspamd", "-f", "-u", "_rspamd", "-g", "_rspamd"]

