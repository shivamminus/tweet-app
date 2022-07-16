FROM node:16.0-buster-slim
WORKDIR /app
COPY package*.json /app/
COPY ./ /app/

RUN npm install

EXPOSE 3000

RUN npm run build

RUN npm install -g serve

RUN echo npm --version

CMD [ "serve", "-s", "build" ]