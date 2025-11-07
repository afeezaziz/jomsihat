#!/bin/bash

# Coolify Deployment Script for Jom Sihat
# This script helps deploy the application to Coolify

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required environment variables are set
check_env_vars() {
    print_status "Checking environment variables..."

    required_vars=("COOLIFY_API_TOKEN" "COOLIFY_WEBHOOK_URL" "COOLIFY_APP_URL")
    missing_vars=()

    for var in "${required_vars[@]}"; do
        if [ -z "${!var}" ]; then
            missing_vars+=("$var")
        fi
    done

    if [ ${#missing_vars[@]} -ne 0 ]; then
        print_error "Missing required environment variables: ${missing_vars[*]}"
        print_status "Please set these variables in your GitHub repository secrets or .env file"
        exit 1
    fi

    print_success "All required environment variables are set"
}

# Pre-deployment checks
pre_deployment_checks() {
    print_status "Running pre-deployment checks..."

    # Check if Docker is installed (for local testing)
    if command -v docker &> /dev/null; then
        print_success "Docker is available"
    else
        print_warning "Docker is not available (this is OK for CI/CD)"
    fi

    # Check if required files exist
    required_files=("Dockerfile" "requirements.txt" "app.py" "coolify.json")
    for file in "${required_files[@]}"; do
        if [ -f "$file" ]; then
            print_success "$file exists"
        else
            print_error "$file not found"
            exit 1
        fi
    done
}

# Build Docker image locally (for testing)
build_local_image() {
    if [ "$1" = "--local" ]; then
        print_status "Building Docker image locally..."

        IMAGE_NAME="jomsihat:local"
        docker build -t "$IMAGE_NAME" .

        print_success "Docker image built successfully: $IMAGE_NAME"

        # Test the image
        print_status "Testing Docker image..."
        docker run --rm -d -p 5000:5000 --name jomsihat-test "$IMAGE_NAME"

        # Wait for the container to start
        sleep 10

        # Health check
        if curl -f http://localhost:5000/health; then
            print_success "Local health check passed"
            docker stop jomsihat-test
        else
            print_error "Local health check failed"
            docker logs jomsihat-test
            docker stop jomsihat-test
            exit 1
        fi
    fi
}

# Trigger Coolify deployment
trigger_coolify_deployment() {
    print_status "Triggering Coolify deployment..."

    # Get current Git info
    BRANCH=${GITHUB_REF_NAME:-$(git branch --show-current)}
    COMMIT=${GITHUB_SHA:-$(git rev-parse HEAD)}

    # Prepare payload
    PAYLOAD=$(cat <<EOF
{
    "image": "ghcr.io/afeezaziz/jomsihat:latest",
    "branch": "$BRANCH",
    "commit": "$COMMIT",
    "deployed_by": "$(git config user.name)",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF
)

    print_status "Sending deployment request to Coolify..."

    # Send webhook to Coolify
    RESPONSE=$(curl -s -w "%{http_code}" -o /tmp/coolify_response.json \
        -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $COOLIFY_API_TOKEN" \
        -d "$PAYLOAD" \
        "$COOLIFY_WEBHOOK_URL")

    if [ "$RESPONSE" = "200" ]; then
        print_success "Deployment request sent successfully"
        print_status "Coolify response:"
        cat /tmp/coolify_response.json | jq . 2>/dev/null || cat /tmp/coolify_response.json
    else
        print_error "Failed to send deployment request (HTTP $RESPONSE)"
        print_status "Response:"
        cat /tmp/coolify_response.json
        exit 1
    fi
}

# Monitor deployment
monitor_deployment() {
    print_status "Monitoring deployment..."

    MAX_ATTEMPTS=30
    ATTEMPT=1

    while [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
        print_status "Health check attempt $ATTEMPT of $MAX_ATTEMPTS"

        if curl -f -s "$COOLIFY_APP_URL/health" > /dev/null; then
            print_success "✅ Application deployed successfully and is healthy!"
            print_success "🌐 Application is available at: $COOLIFY_APP_URL"
            return 0
        fi

        print_status "Application not ready yet, waiting 30 seconds..."
        sleep 30
        ATTEMPT=$((ATTEMPT + 1))
    done

    print_error "❌ Deployment failed or application is not healthy after $MAX_ATTEMPTS attempts"
    exit 1
}

# Rollback function
rollback() {
    print_warning "Rollback requested..."

    # Implement rollback logic (this depends on your Coolify setup)
    print_status "Rollback functionality would be implemented here based on your Coolify configuration"
}

# Main deployment function
main() {
    print_status "🚀 Starting Jom Sihat deployment to Coolify..."

    check_env_vars
    pre_deployment_checks
    build_local_image "$1"
    trigger_coolify_deployment

    if [ "$1" != "--no-monitor" ]; then
        monitor_deployment
    fi

    print_success "🎉 Deployment completed successfully!"
}

# Handle script arguments
case "${1:-}" in
    --local)
        main --local
        ;;
    --no-monitor)
        main --no-monitor
        ;;
    --rollback)
        rollback
        ;;
    --help)
        echo "Usage: $0 [OPTIONS]"
        echo ""
        echo "Options:"
        echo "  --local       Build and test image locally before deployment"
        echo "  --no-monitor  Skip deployment monitoring"
        echo "  --rollback    Rollback to previous version"
        echo "  --help        Show this help message"
        exit 0
        ;;
    *)
        main
        ;;
esac