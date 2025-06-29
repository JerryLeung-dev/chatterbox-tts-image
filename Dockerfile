# Use slim Python base (GPU support comes from RunPod environment)
FROM python:3.10-slim

# Environment setup
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.local/bin:$PATH"

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    curl \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    && apt-get clean

# Create app directory
WORKDIR /workspace

# Clone chatterboxPro repo
RUN git clone https://github.com/Jeremy-Harper/chatterboxPro.git .
# Install correct GPU-compatible torch from official PyTorch index
RUN pip install torch==2.7.0 --index-url https://download.pytorch.org/whl/cu121

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Set the default command to launch chatterbox
CMD ["python", "chatter_pro.py"]
