#!/bin/bash

# IGV Studio startup script for Seqera Platform
set -e

echo "Starting IGV Web App Studio..."
echo "Using port: ${CONNECT_TOOL_PORT}"

# Check if CONNECT_TOOL_PORT is set
if [ -z "$CONNECT_TOOL_PORT" ]; then
    echo "Error: CONNECT_TOOL_PORT environment variable is not set"
    exit 1
fi

# Create nginx configuration with dynamic port
sed "s/CONNECT_TOOL_PORT_PLACEHOLDER/${CONNECT_TOOL_PORT}/g" /etc/nginx/sites-available/igv-app > /tmp/nginx.conf
sudo cp /tmp/nginx.conf /etc/nginx/sites-available/igv-app

# Test nginx configuration
nginx -t

# Start nginx in foreground mode
echo "Starting nginx on port ${CONNECT_TOOL_PORT}"
echo "IGV Web App will be available at the Studio URL"

# Handle SIGTERM gracefully
trap 'echo "Shutting down nginx..."; nginx -s quit; exit 0' SIGTERM

# Start nginx
exec nginx -g 'daemon off;'