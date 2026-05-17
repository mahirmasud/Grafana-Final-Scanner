FROM python:3.11-slim

LABEL maintainer="Grafana Final Scanner Team" \
      description="Grafana Final Scanner - Professional Vulnerability Assessment Tool" \
      version="2.0.0"

# Set working directory
WORKDIR /app

# Create non-root user for security
RUN addgroup --system --gid 1001 scanner && \
    adduser --system --uid 1001 --gid 1001 --no-create-home scanner

# Install dependencies first (better layer caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy scanner code
COPY scanner.py .
RUN chmod +x scanner.py

# Create output directory for reports
RUN mkdir -p /app/reports && chown scanner:scanner /app/reports

# Switch to non-root user
USER scanner

# Set entrypoint
ENTRYPOINT ["python", "scanner.py"]

# Default command shows help
CMD ["--help"]
