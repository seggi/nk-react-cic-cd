FROM node:14 AS build

LABEL version="1.0.0"

LABEL description="This is microservice app test with docker"

WORKDIR /usr/src/app
COPY package*.json .gitignore ./
RUN npm install glob rimraf
RUN npm install
COPY . .

RUN npm build

# # Stage - Production
FROM nginx:1.17-alpine
# COPY --from=build /usr/src/app/build /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

