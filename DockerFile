# Build the proyect
FROM node:lts AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Select the nginx image
FROM nginx:alpine

# Tell nginx the build path
COPY --from=build /app/dist /usr/share/nginx/html
# Start nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]