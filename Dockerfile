FROM ghcr.io/twin-digital/devcontainer-base:edge

# Suppress an apt-key warning about standard out not being a terminal. Use in this script is safe.
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

ENV NVM_DIR /home/devuser/.nvm
ENV DEFAULT_NODE_VERSION 12

# install nvm, node, npm, and yarn
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash \
  && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \
  && nvm install $DEFAULT_NODE_VERSION \
  && nvm alias default $DEFAULT_NODE_VERSION \
  && nvm use default \
  && npm install -g yarn