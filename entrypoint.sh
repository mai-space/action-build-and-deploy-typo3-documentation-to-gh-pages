#!/bin/bash
set -e

echo "#################################################"
echo "> Starting ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"

# Available env
echo "DOCUPATH: ${DOCUPATH}"

# Start Docker container
docker-compose -f docker-compose.docs.yaml up -d docs

# Wait for the container to initialize (if needed)

# Find the container name based on the image name
container_name=$(docker ps --filter ancestor=ghcr.io/t3docs/render-documentation:latest --format '{{.Names}}')

# Check if the container name was found
if [[ -z "$container_name" ]]; then
  echo "Container not found. Exiting..."
  exit 1
fi

# Build documentation inside the Docker container
docker exec -it "$container_name" makehtml

# Trigger gh-pages deployment
publish_dir="Documentation-GENERATED-temp/Result/project/0.0.0"

echo "Deploying to gh-pages..."
curl -X POST "https://api.github.com/repos/$GITHUB_REPOSITORY/pages/builds" -H "Authorization: Bearer $GITHUB_TOKEN"

# Stop Docker container
docker-compose -f /path/to/your/docker-compose.docs.yaml down

echo "#################################################"
echo "Completed ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"