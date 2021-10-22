FROM ghcr.io/twin-digital/devcontainer-base:main

# Suppress an apt-key warning about standard out not being a terminal. Use in this script is safe.
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

ENV NVM_DIR /home/devuser/.nvm
ENV DEFAULT_NODE_VERSION 14

# install nvm, node, npm, and yarn
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash \
  && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \
  && nvm install $DEFAULT_NODE_VERSION \
  && nvm alias default $DEFAULT_NODE_VERSION \
  && nvm use default \
  && npm install -g yarn

# install other packages
COPY container/packages.txt /usr/local/etc/devcontainer/nodejs/
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo install-packages /usr/local/etc/devcontainer/nodejs/packages.txt
