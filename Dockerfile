FROM ubuntu:latest

RUN set -e;  \
    apt-get update && apt-get install -y curl apt-transport-https ca-certificates gnupg; \
    echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(. /etc/lsb-release; echo "$DISTRIB_CODENAME") main" > /etc/apt/sources.list.d/hashicorp.list; \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -; \
    apt-get update -o Dir::Etc::sourcelist=sources.list.d/hashicorp.list -o Dir::Etc::sourceparts=- -o APT::Get::List-Cleanup=0; \
    apt-get install -y packer; \
    curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o /tmp/session-manager-plugin.deb; \
    dpkg -i /tmp/session-manager-plugin.deb; \
    apt-get autoremove -y curl apt-transport-https ca-certificates gnupg; \
    apt-get clean

COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
