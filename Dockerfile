# build environment
FROM node:10-alpine as build
WORKDIR /app
COPY package*.json /app/
RUN npm install --silent
#RUN npm install react-scripts@3.0.1 -g --silent
COPY . /app
RUN npm run build

# production environment
FROM nginx:1.16.0-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
