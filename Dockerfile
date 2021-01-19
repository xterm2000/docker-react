#production build
#multistep build phases

# named builder 
# FROM node:alpine as builder

#step 0
FROM node:alpine

#set working dir on container 
WORKDIR '/app'

#copy yhe package to container 
COPY package.json .
#install dependecies
RUN npm install
#copy the rest 
COPY . .
#build 
RUN npm run build


# /app/build <-- all the files
# so in step 2 only they are copied to the image 

#step 1

#named 
# COPY --from=builder 
FROM nginx:alpine
# port expose for beanstalk
EXPOSE 80 
COPY --from=0 /app/build /usr/share/nginx/html
