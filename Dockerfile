# Use an official Node.js runtime as a parent image
FROM node:20

# Set the working directory in the container to /app
WORKDIR /app

# Clone the StandX fork, NOT the upstream DefiLlama repository.
# Cloning upstream here would silently discard the fork's own adapters and
# pegged-asset data (for example the standx-dusd entry), so the deployed image
# would not contain the code that this repository actually maintains.
RUN git clone https://github.com/standx-labs/defillama-peggedassets-server /app/repo

# Change to the directory of the repository
WORKDIR /app/repo

# Install dependencies from the committed lockfile so the image is reproducible
# and does not resolve floating dependency ranges at build time.
RUN npm ci

# Make port 5001 available to the world outside this container
EXPOSE 5001

# bash command to keep the container running
CMD ["bash", "-c", "npm run api2-prod; while true; do sleep 10000; done"]