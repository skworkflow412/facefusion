# Use an official Python-based image with CUDA support
FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt update && apt install -y \
    python3 python3-pip ffmpeg git curl unzip \
    && rm -rf /var/lib/apt/lists/*

# Install FaceFusion dependencies
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy FaceFusion source code
COPY . .

# Expose the default FaceFusion web UI port
EXPOSE 7860

# Run the application
CMD ["python3", "facefusion.py"]
