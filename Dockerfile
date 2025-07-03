FROM python:3.8-slim-buster

WORKDIR /app

# Copy all files
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose port (if using Flask or similar)
EXPOSE 5000

# Run the app
CMD ["python3", "app.py"]
