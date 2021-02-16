FROM alpine

RUN apk add --update --no-cache --virtual .build-deps \
      build-base \
      libusb-dev \
      libusb-compat-dev \
      make \
      git \
    && apk add --no-cache \
      curl \
      libusb \
      libusb-compat \
      jq \
    \
    # Build
    && git clone https://github.com/sergiokhayyat/temper /app \
    && cd /app \
    && make temper_json \
    && install -m 755 temper_json /usr/local/bin \
    \
    # Clean
    && apk del --purge .build-deps \
    && rm -rf /app

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENV INTERVAL=60
ENTRYPOINT ["/entrypoint.sh"]
