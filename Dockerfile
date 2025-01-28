# Use the official Python image from the Docker Hub
FROM python:3

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /data

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-distutils \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install django==3.2

# Copy the current directory contents into the container at /data
COPY . .

# Run the application
RUN python manage.py migrate

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

