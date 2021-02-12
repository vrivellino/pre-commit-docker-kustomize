FROM alpine:latest
RUN adduser kustomize -D \
  && apk add curl git openssh \
  && git config --global url.ssh://git@github.com/.insteadOf https://github.com/
RUN  curl -L --output /tmp/kustomize_linux_amd64.tar.gz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.9.4/kustomize_v3.9.4_linux_amd64.tar.gz \
  && echo "439c6bda9086399477e4f847b16b9b45ee695391b4f5d6e4107374ad149050b0  /tmp/kustomize_linux_amd64.tar.gz" | sha256sum -c \
  && tar -xvzf /tmp/kustomize_linux_amd64.tar.gz -C /usr/local/bin \
  && chmod +x /usr/local/bin/kustomize \
  && mkdir ~/.ssh \
  && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
USER kustomize
WORKDIR /src
