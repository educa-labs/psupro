# base image
FROM node:9.6.1

# set working directory
RUN mkdir /usr/src/app
WORKDIR /usr/src/app

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json /usr/src/app/package.json
COPY src /usr/src/app/src
COPY scripts /usr/src/app/scripts
COPY config /usr/src/app/config
COPY public /usr/src/app/public

RUN npm install 
RUN npm install -g serve 


# start app
RUN npm run build

CMD serve -s front/build