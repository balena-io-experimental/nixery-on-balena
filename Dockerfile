FROM nixos/nix:2.9.1 as nix

WORKDIR /app

# RUN git clone https://code.tvl.fyi/depot.git:/tools/nixery.git . && \
#     nix-build -A nixery

# build nixery from fork with armv7 meta-package
RUN git clone https://github.com/klutchell/nixery.git -b kyle/armv7l . && \
    nix-build -A nixery

ENV NIX_SSL_CERT_FILE /etc/ssl/certs/ca-bundle.crt

# create the build user/group required by nix
RUN echo 'nixbld:x:30000:nixbld' >> /etc/group && \
    echo 'nixbld:x:30000:30000:nixbld:/tmp:/bin/bash' >> /etc/passwd && \
    echo 'root:x:0:0:root:/root:/bin/bash' >> /etc/passwd && \
    echo 'root:x:0:' >> /etc/group

WORKDIR /etc/nix

# disable sandboxing to avoid running into privilege issues
RUN echo 'sandbox = false' >> /etc/nix/nix.conf

# enable extra ARM platforms
RUN echo "extra-platforms = aarch64-linux arm-linux armv7l-linux" >> /etc/nix/nix.conf

# add community armv7 cache via https://app.cachix.org/cache/thefloweringash-armv7
RUN nix-env -iA cachix -f https://cachix.org/api/v1/install && \
    cachix use thefloweringash-armv7

VOLUME /storage

WORKDIR /app

CMD [ "/app/result/bin/server" ]
