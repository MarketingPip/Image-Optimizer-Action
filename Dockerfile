# Dockerfile - created by github.com/MarketingPipeline
FROM debian:stable

# Install system dependencies required for Pillow and other Python dependencies
RUN apt-get update -y && apt-get install -y \
    python3 \
    python3-pip \
    libjpeg-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*  # Clean up apt cache to reduce image size

# Ensure pip is up to date (handling any potential missing pip issues)
RUN python3 -m ensurepip --upgrade
RUN python3 -m pip install --no-cache-dir --upgrade pip

# Install Python dependencies for the project
RUN pip3 install --no-cache-dir pillow optimize-images

# Copy the entry point script into the container
COPY entrypoint /usr/local/bin/

# Make the entry point executable
RUN chmod +x /usr/local/bin/entrypoint

# Define the entry point for the container
ENTRYPOINT ["/usr/local/bin/entrypoint"]
