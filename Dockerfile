#multistep build phases

#named builder FROM node:alpine as builder
#step 1 
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#step 2
FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html