# Stage 1: Build stage
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

# Stage 2: Production stage
FROM node:alpine

# Set the working directory
WORKDIR /app

# Copy the built application from the builder stage
COPY --from=builder /app .

# Install only production dependencies
RUN npm install --only=production

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application
CMD ["node", "index.js"]
