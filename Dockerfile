FROM node:16-alpine As development

WORKDIR /usr/src/app

COPY package*.json ./

RUN yarn --only=development

COPY . .

FROM node:16-alpine as production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package*.json ./

RUN yarn --only=production

COPY . .

COPY --from=development /usr/src/app/dist ./dist

CMD ["node", "dist/main"]