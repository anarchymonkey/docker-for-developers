FROM node:16

WORKDIR /projects/client

COPY package.json .

RUN npm install

COPY . .

EXPOSE 1234

CMD ["npm", "start"]