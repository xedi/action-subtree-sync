FROM alpine:3.10.2

COPY resources/root /root

RUN apk add git \
    openssh \
    git-subtree

ENTRYPOINT ["/root/entrypoint.sh"]
