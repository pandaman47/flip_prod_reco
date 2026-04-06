# Use the official Python 3.11 slim image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set the working directory in the container
WORKDIR /app

# Install uv
RUN pip install uv

# Copy the uv lock file and pyproject.toml (if using uv)
COPY pyproject.toml uv.lock* .

# Install dependencies using uv
RUN uv sync --frozen --no-dev

# Copy the rest of the application code
COPY . .

# Used PORTS
EXPOSE 5000

# Specify the command to run the application
CMD ["python", "app.py"]
#
### Parent image
#FROM python:3.10-slim
#
### Essential environment variables
#ENV PYTHONDONTWRITEBYTECODE=1 \
#    PYTHONUNBUFFERED=1
#
### Work directory inside the docker container
#WORKDIR /app
#
### Installing system dependancies
#RUN apt-get update && apt-get install -y \
#    build-essential \
#    curl \
#    && rm -rf /var/lib/apt/lists/*
#
### Copying ur all contents from local to app
#COPY . .
#
### Run setup.py
#RUN pip install --no-cache-dir -e .
#
## Used PORTS
#EXPOSE 5000
#
## Run the app 
#CMD ["python", "app.py"]
#