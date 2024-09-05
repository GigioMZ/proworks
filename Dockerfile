# Use a base image with Hugo installed
FROM klakegg/hugo:0.124.1-ext

# Install dependencies for Yarn
RUN apk add --no-cache curl

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apk add --no-cache nodejs

# Install Yarn
RUN npm install -g yarn

# Set the working directory
WORKDIR /app

# Copy package.json and yarn.lock
COPY package.json yarn.lock ./

# Install project dependencies
RUN yarn install

# Copy the rest of the application code
COPY . .

# Build the project
RUN yarn build

# Set the command to run Hugo server
CMD ["hugo", "server", "--bind", "0.0.0.0"]
