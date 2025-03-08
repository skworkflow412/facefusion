# Use lightweight CUDA image for GPU support
FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04

WORKDIR /app

# Install system dependencies
RUN apt update && apt install -y \
    python3 python3-pip ffmpeg git curl unzip \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (use caching)
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy the entire FaceFusion source code
COPY . .

# Expose the FaceFusion UI port
EXPOSE 7860

# Run FaceFusion
CMD ["python3", "facefusion.py"]
