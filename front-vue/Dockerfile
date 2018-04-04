# base image
FROM node:9.6.1

# set working directory
RUN mkdir /usr/app/
WORKDIR /usr/app/front-vue/

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/app/front-vue/node_modules/.bin:$PATH

# install and cache app dependencies
ADD package.json ./package.json
COPY src /usr/app/front-vue/src

RUN npm install
EXPOSE 8080

CMD npm run dev