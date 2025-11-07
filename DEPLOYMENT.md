# 🐳 Docker Deployment Guide for Jom Sihat

This guide will help you deploy the Jom Sihat fitness platform using Docker and Docker Compose.

## 📋 Prerequisites

- Docker Engine 20.10+
- Docker Compose v2.0+
- Git

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone <your-repository-url>
cd jomsihat
```

### 2. Environment Configuration
```bash
# Copy the environment template
cp .env.example .env

# Edit the .env file with your configuration
nano .env
```

**Important:** Set a secure `SECRET_KEY` in your `.env` file:
```bash
SECRET_KEY=your-very-secure-secret-key-change-this-in-production
```

### 3. Basic Deployment
```bash
# Build and start the application
docker-compose up -d

# Check the logs
docker-compose logs -f
```

The application will be available at: `http://localhost:5000`

## 🏗️ Production Deployment

### Option 1: Simple Production Setup
```bash
# Deploy with production optimizations
docker-compose -f docker-compose.yml --profile production up -d
```

This will include:
- Nginx reverse proxy (port 80)
- Redis for session storage
- Optimized production settings

### Option 2: Manual Docker Build
```bash
# Build the Docker image
docker build -t jomsihat:latest .

# Run the container
docker run -d \
  --name jomsihat \
  -p 5000:5000 \
  -e SECRET_KEY=your-secret-key \
  -e FLASK_ENV=production \
  jomsihat:latest
```

## 🔧 Configuration

### Environment Variables
| Variable | Description | Default |
|----------|-------------|---------|
| `FLASK_ENV` | Flask environment | `production` |
| `FLASK_APP` | Flask app module | `app.py` |
| `SECRET_KEY` | Session encryption key | Required |
| `HOST` | Host to bind to | `0.0.0.0` |
| `PORT` | Port to listen on | `5000` |

### Nginx Configuration
The included Nginx configuration provides:
- Static file serving with caching
- Gzip compression
- Rate limiting (10 requests/second)
- Security headers
- Reverse proxy to Flask app

### SSL/HTTPS Setup
1. Place your SSL certificates in the `ssl/` directory:
   ```
   ssl/
   ├── cert.pem
   └── key.pem
   ```

2. Uncomment the HTTPS server block in `nginx/nginx.conf`

3. Restart the services:
   ```bash
   docker-compose restart nginx
   ```

## 📊 Monitoring and Logs

### View Logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f web
docker-compose logs -f nginx
```

### Health Checks
```bash
# Check container status
docker-compose ps

# Health check endpoint
curl http://localhost/health
```

### Performance Monitoring
The Docker setup includes:
- Health checks with 30-second intervals
- Automatic restarts on failure
- Resource limits (if configured)

## 🔒 Security Considerations

1. **Secret Key**: Always set a strong, random `SECRET_KEY`
2. **HTTPS**: Use SSL certificates in production
3. **Firewall**: Configure firewall to allow only necessary ports
4. **Regular Updates**: Keep Docker images updated
5. **Backup**: Regularly backup your translations and custom content

## 🛠️ Development vs Production

### Development
```bash
# Run in development mode
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up
```

### Production
```bash
# Run in production mode
docker-compose -f docker-compose.yml --profile production up -d
```

## 📁 File Structure
```
jomsihat/
├── Dockerfile                 # Main Docker image definition
├── docker-compose.yml         # Production orchestration
├── .dockerignore             # Files to exclude from Docker build
├── .env.example              # Environment variables template
├── app/                      # Flask application
│   ├── templates/            # HTML templates
│   ├── static/              # Static files
│   └── translations.json    # Language translations
├── nginx/                   # Nginx configuration
│   └── nginx.conf           # Nginx settings
├── ssl/                     # SSL certificates (create as needed)
└── requirements.txt         # Python dependencies
```

## 🔍 Troubleshooting

### Common Issues

1. **Port Already in Use**
   ```bash
   # Check what's using the port
   lsof -i :5000

   # Kill the process
   kill -9 <PID>
   ```

2. **Permission Issues**
   ```bash
   # Fix Docker permissions
   sudo chown -R $USER:$USER .
   ```

3. **Build Failures**
   ```bash
   # Clear Docker cache
   docker system prune -a

   # Rebuild
   docker-compose build --no-cache
   ```

4. **Container Not Starting**
   ```bash
   # Check logs
   docker-compose logs web

   # Check configuration
   docker-compose config
   ```

### Performance Optimization

1. **Enable BuildKit for faster builds:**
   ```bash
   export DOCKER_BUILDKIT=1
   docker-compose build
   ```

2. **Use multi-stage builds for smaller images**

3. **Configure resource limits:**
   ```yaml
   deploy:
     resources:
       limits:
         cpus: '0.5'
         memory: 512M
   ```

## 📞 Support

If you encounter issues:
1. Check the logs: `docker-compose logs`
2. Verify environment variables in `.env`
3. Ensure Docker and Docker Compose are up to date
4. Check port availability

## 🔄 Updates and Maintenance

### Update Application
```bash
# Pull latest changes
git pull

# Rebuild and restart
docker-compose build
docker-compose up -d
```

### Backup Data
```bash
# Backup translations and custom files
docker cp $(docker-compose ps -q web):/app/app/translations.json ./backup/
```

### Clean Up
```bash
# Remove unused containers and images
docker system prune -a
```