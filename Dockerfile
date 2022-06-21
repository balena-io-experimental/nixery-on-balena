FROM nixos/nix:2.9.1 as nix

WORKDIR /app

RUN git clone https://code.tvl.fyi/depot.git:/tools/nixery.git . && \
    nix-build -A nixery

ENV NIX_SSL_CERT_FILE /etc/ssl/certs/ca-bundle.crt

# Create the build user/group required by Nix
RUN echo 'nixbld:x:30000:nixbld' >> /etc/group && \
    echo 'nixbld:x:30000:30000:nixbld:/tmp:/bin/bash' >> /etc/passwd && \
    echo 'root:x:0:0:root:/root:/bin/bash' >> /etc/passwd && \
    echo 'root:x:0:' >> /etc/group

# Disable sandboxing to avoid running into privilege issues
WORKDIR /etc/nix
RUN echo 'sandbox = false' >> /etc/nix/nix.conf
WORKDIR /app

VOLUME /storage

CMD [ "/app/result/bin/server" ]
