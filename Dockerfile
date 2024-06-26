# Use the official lightweight Node.js 14 image
FROM node:14-alpine as build

RUN echo "hello"

# Set working directory
#WORKDIR /app/my-app

# Copy package.json and package-lock.json
COPY package*.json ./my-app

# Install dependencies
RUN npm install

RUN ls -al

RUN pwd

RUN echo "before*****************"
# Copy app source
COPY ./my-app .

RUN ls -al

RUN pwd

RUN echo "After*****************"

#RUN cd my-app

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
