FROM node:16-alpine
WORKDIR /opt/
COPY package.json /opt/
RUN npm install
COPY ./ /opt/
RUN npm run build
EXPOSE 80
CMD ["npm" ,"run", "start" ]
