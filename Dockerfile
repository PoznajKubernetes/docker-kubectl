FROM alpine:3.11

MAINTAINER Piotrek Stapp <piotrek@poznajkubernetes.pl>

ARG VCS_REF
ARG BUILD_DATE
ARG KUBECTL_VERSION
ARG KUBEVAL_VERSION

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/poznajkubernetes/docker-kubectl" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile"


ENV KUBECTL_VERSION=${KUBECTL_VERSION}

ENV KUBEVAL_VERSION=${KUBEVAL_VERSION}

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && wget https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz \
 && tar xf kubeval-linux-amd64.tar.gz \
 && cp kubeval /usr/local/bin \
 && chmod +x /usr/local/bin/kubeval \
 && apk del --purge deps \
 && rm -rf /var/cache/apk/*

ENTRYPOINT ["kubectl"]
CMD ["help"]