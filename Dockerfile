# Use an official Node.js image (arm64 compatible for RPi 4)
FROM node:22-alpine

# Create and switch to app directory
WORKDIR /app

# Copy package.json and lock file first (better for caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the code
COPY . .

# Build the Adonis project
RUN npm run build

# Expose port 3333 
EXPOSE 3333

# Start the app

CMD ["npm", "start"]
