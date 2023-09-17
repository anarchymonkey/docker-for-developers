FROM node:16

WORKDIR /client

COPY package.json .

RUN npm install

COPY . .

EXPOSE 1234

CMD ["npm", "start"]