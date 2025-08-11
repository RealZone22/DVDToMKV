FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y handbrake-cli libdvd-pkg && \
    dpkg-reconfigure libdvd-pkg && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /data

COPY rip.sh /usr/local/bin/rip.sh
RUN chmod +x /usr/local/bin/rip.sh

CMD ["bash", "/usr/local/bin/rip.sh"]
