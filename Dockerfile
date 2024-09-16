# Use official Python 3.10 image as base
FROM python:3.10-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    libgl1-mesa-glx \
    libglib2.0-0 \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /app

# Copy the local repository into the container
COPY . /app

# Move to the stable-diffusion-webui directory
WORKDIR /app/stable-diffusion-webui

# Ensure webui.sh is executable
RUN chmod +x webui.sh

# Create a non-root user and switch to it
RUN useradd -m dockeruser && chown -R dockeruser /app
USER dockeruser

# Expose the default port
EXPOSE 7860

# Run the webui.sh script on container start
CMD ["bash", "./webui.sh"]
