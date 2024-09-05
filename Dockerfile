# Use a base image with Go pre-installed
FROM golang:1.22.2 AS build

# Install Hugo
RUN wget https://github.com/goharbor/harbor/releases/download/v0.124.1/hugo_extended_0.124.1_Linux-64bit.tar.gz && \
    tar -xzf hugo_extended_0.124.1_Linux-64bit.tar.gz && \
    mv hugo /usr/local/bin/hugo

# Set up working directory
WORKDIR /app

# Copy the project files
COPY . .

# Run the build command
RUN yarn project-setup && yarn build

# Use an nginx image to serve the built files
FROM nginx:alpine

# Copy the built files from the previous stage
COPY --from=build /app/public /usr/share/nginx/html

# Expose port 80
EXPOSE 80
