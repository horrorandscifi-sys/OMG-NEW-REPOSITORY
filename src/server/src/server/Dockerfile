FROM node:20-bullseye
WORKDIR /app
RUN apt-get update && apt-get install -y build-essential python3
COPY . .
RUN npm install && npx node-gyp rebuild
CMD ["node", "dist/server/app.js"]
