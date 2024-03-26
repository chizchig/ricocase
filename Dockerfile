# Use node:alpine as the base image for the builder stage
FROM node:alpine AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application code
COPY . .

# Build the application
RUN npm run build

# Start a new stage from node:alpine to create a lightweight production image
FROM node:alpine

# Set the working directory in the image
WORKDIR /app

# Copy the built application from the builder stage
COPY --from=builder /app .

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
