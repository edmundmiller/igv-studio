#!/bin/bash

# IGV Studio Build Script
set -e

# Configuration
IMAGE_NAME="igv-studio"
TAG="${1:-latest}"
REGISTRY="${REGISTRY:-}"

echo "Building IGV Web App Studio..."
echo "Image: ${IMAGE_NAME}:${TAG}"

# Build the Docker image
docker build -t "${IMAGE_NAME}:${TAG}" .

# Tag for registry if specified
if [ ! -z "$REGISTRY" ]; then
    echo "Tagging for registry: ${REGISTRY}/${IMAGE_NAME}:${TAG}"
    docker tag "${IMAGE_NAME}:${TAG}" "${REGISTRY}/${IMAGE_NAME}:${TAG}"
fi

echo "Build completed successfully!"
echo ""
echo "To test locally:"
echo "  docker-compose up"
echo ""
echo "To push to registry (if tagged):"
echo "  docker push ${REGISTRY}/${IMAGE_NAME}:${TAG}"
echo ""
echo "For Seqera Platform, use image:"
echo "  ${REGISTRY:-}${REGISTRY:+/}${IMAGE_NAME}:${TAG}"