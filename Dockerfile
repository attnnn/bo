# Use the official lightweight Node.js 14 image
FROM node:14-alpine as build

# Set working directory
WORKDIR my-app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy app source
COPY . .

# Build app
RUN npm run build

# Production environment
FROM nginx:alpine

# Copy build from previous stage
COPY --from=build /my-app/build /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
