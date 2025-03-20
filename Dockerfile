# Use an official Node.js image (arm64 compatible for RPi 4)
FROM node:20-alpine

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

# Expose port 3333 (the default for Adonis)
EXPOSE 3333

# Start the app
#CMD ["node", "build/server.js"]

CMD ["npm", "start"]
