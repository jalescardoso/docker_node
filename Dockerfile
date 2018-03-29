FROM node:8.11.0

RUN useradd --user-group --create-home --shell /bin/false app &&\
  npm install --global npm@5.6.0

ENV HOME=/home/app

COPY package.json npm-shrinkwrap.json $HOME/helloword/
RUN chown -R app:app $HOME/*

USER app
WORKDIR $HOME/helloword
RUN npm cache clean --force && npm install --silent --progress=false

USER root
COPY . $HOME/helloword
RUN chown -R app:app $HOME/*
USER app

CMD ["npm", "start"]