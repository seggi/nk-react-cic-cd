FROM  node:12.19.0-alpine3.9  AS production

WORKDIR /app

COPY package*.json ./

RUN yarn cache clean && yarn --update-checksums

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn && yarn build

FROM nginx:1.19-alpine AS server

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

COPY --from=production ./app/build /usr/share/nginx/html

EXPOSE 300

CMD ["nginx", "-g", "daemon off;"]

