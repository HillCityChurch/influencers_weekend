FROM alpine:latest

ENV HUGO_VERSION=0.30.2
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz /tmp
RUN tar -xf /tmp/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -C /tmp \
    && mkdir -p /usr/local/sbin \
    && mv /tmp/hugo /usr/local/sbin/hugo \
    && rm -rf /tmp/hugo_${HUGO_VERSION}_linux_amd64 \
    && export PATH="/usr/local/sbin/hugo:$PATH"
    
RUN apk update \
    && apk upgrade \
    && apk add --no-cache ca-certificates

COPY . /opt/src

WORKDIR /opt/src

EXPOSE 1313
CMD ["sh", "-c", "hugo server"]