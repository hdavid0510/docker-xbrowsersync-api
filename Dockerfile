FROM node:14.21-alpine

WORKDIR /usr/src/api
COPY . /usr/src/api/

# Install dependencies
RUN npm install --only=production  --loglevel verbose \
	&& npm audit fix \
	&& npm cache clean --force

# Expose port and start api
EXPOSE 8080
CMD [ "node", "dist/api.js"]
