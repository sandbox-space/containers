FROM alpine:latest

ARG VERSION=2.0.0

RUN apk add --no-cache \
  python3 \
  py-pip \
  py-setuptools \
  git \
  ca-certificates \
  openssl 

RUN true \
  && pip install python-magic \
  && git clone https://github.com/s3tools/s3cmd.git /tmp/s3cmd \
  && cd /tmp/s3cmd \
  && git checkout ${VERSION} \
  && python3 /tmp/s3cmd/setup.py install \
  && rm -rf /tmp/s3cmd \
  && apk del py-pip git

WORKDIR /root

ENV PATH=/root/bin:$PATH

COPY docker-php-entrypoint /usr/local/bin/

ENTRYPOINT ["docker-php-entrypoint"]
CMD ["--help"]