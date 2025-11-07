# 🚀 Coolify Deployment Guide for Jom Sihat

This guide will help you deploy the Jom Sihat fitness platform using **GitHub Actions + Coolify** - the recommended approach for modern CI/CD deployment.

## 🎯 Why GitHub Actions + Coolify?

### ✅ Advantages over Dockerfile-only deployment:
- **Automated CI/CD pipeline** - builds, tests, and deploys automatically
- **GitHub integration** - seamless integration with your code repository
- **Rollback capabilities** - easy rollback to previous versions
- **Health monitoring** - built-in health checks and monitoring
- **Security scanning** - automated vulnerability scanning
- **Multi-environment support** - staging, production, etc.
- **Zero-downtime deployments** - rolling updates
- **Scalability** - automatic scaling based on load
- **SSL management** - automatic SSL certificate management
- **Backup automation** - automated backups

## 📋 Prerequisites

- GitHub repository with your code
- Coolify instance (self-hosted or cloud)
- Docker registry (GitHub Container Registry recommended)
- Domain name (for production)

## 🛠️ Setup Instructions

### 1. GitHub Repository Setup

```bash
# Add your code to GitHub
git remote add origin https://github.com/your-username/jomsihat.git
git push -u origin main
```

### 2. GitHub Secrets Configuration

In your GitHub repository, go to **Settings → Secrets and variables → Actions** and add:

| Secret Name | Description | Example |
|-------------|-------------|---------|
| `COOLIFY_API_TOKEN` | Your Coolify API token | `coolify_token_abc123` |
| `COOLIFY_WEBHOOK_URL` | Coolify webhook URL | `https://coolify.yourdomain.com/webhook/deploy` |
| `COOLIFY_APP_URL` | Your application URL | `https://jomsihat.com` |
| `SLACK_WEBHOOK_URL` | (Optional) Slack notifications | `https://hooks.slack.com/...` |

### 3. Coolify Configuration

1. **Create a new application** in Coolify
2. **Choose Docker Compose** as the application type
3. **Link your GitHub repository**
4. **Configure environments** (production, staging, etc.)
5. **Set up domains** and SSL certificates

### 4. Container Registry Setup

**Using GitHub Container Registry (Recommended):**
```bash
# Enable GitHub Container Registry in your repository settings
# Images will be automatically pushed to: ghcr.io/your-username/jomsihat
```

## 🔄 Deployment Workflow

### Automatic Deployment (Recommended)

1. **Push to main branch** → Automatic deployment to production
2. **Push to develop branch** → Automatic deployment to staging
3. **Create pull request** → Automatic testing and preview deployment

### Manual Deployment

```bash
# Using the deployment script
./scripts/deploy.sh --local    # Test locally first
./scripts/deploy.sh           # Deploy to production

# Or trigger manually in GitHub Actions
# Go to Actions → Deploy to Coolify → Run workflow
```

## 📁 Project Structure for Coolify

```
jomsihat/
├── .github/workflows/
│   └── deploy.yml              # GitHub Actions workflow
├── scripts/
│   └── deploy.sh              # Deployment helper script
├── app/                       # Flask application
├── Dockerfile                 # Multi-stage Docker build
├── docker-compose.yml         # Local development
├── coolify.json              # Coolify configuration
├── requirements.txt          # Python dependencies
└── COOLIFY_DEPLOYMENT.md     # This file
```

## 🔧 Configuration Files

### GitHub Actions Workflow (`.github/workflows/deploy.yml`)
- ✅ **Testing**: Runs automated tests
- ✅ **Security Scanning**: Vulnerability scanning with Trivy
- ✅ **Multi-platform**: Builds for AMD64 and ARM64
- ✅ **Caching**: Docker layer caching for faster builds
- ✅ **Health Checks**: Monitors deployment success
- ✅ **Notifications**: Slack integration for deployment status

### Coolify Configuration (`coolify.json`)
- ✅ **Multi-environment**: Production, staging, development
- ✅ **Auto-scaling**: Automatic scaling based on CPU usage
- ✅ **Health monitoring**: Built-in health checks
- ✅ **Backup automation**: Automatic daily backups
- ✅ **SSL management**: Automatic Let's Encrypt certificates

### Optimized Dockerfile
- ✅ **Multi-stage build**: Smaller, more secure images
- ✅ **Security**: Non-root user, minimal attack surface
- ✅ **Performance**: Optimized for production workloads
- ✅ **Health checks**: Built-in health monitoring

## 🚀 Deployment Process

### 1. Initial Setup
```bash
# 1. Set up GitHub secrets
# 2. Configure Coolify application
# 3. Set up domain and SSL
# 4. Test deployment with staging
```

### 2. Deploy to Staging
```bash
# Push to develop branch
git checkout develop
git add .
git commit -m "Ready for staging deployment"
git push origin develop
```

### 3. Deploy to Production
```bash
# Push to main branch
git checkout main
git merge develop
git push origin main
```

## 📊 Monitoring and Maintenance

### Health Monitoring
- **Automatic health checks** every 30 seconds
- **Alerts** for high CPU/memory usage
- **Logs aggregation** in Coolify dashboard
- **Performance metrics** tracking

### Backup Strategy
- **Daily automatic backups** at 2 AM
- **7-day retention** policy
- **Application and database** backups
- **Easy restoration** from Coolify dashboard

### Scaling Configuration
```json
{
  "min_replicas": 1,
  "max_replicas": 3,
  "target_cpu_utilization": 70
}
```

## 🔒 Security Best Practices

### GitHub Actions Security
- ✅ **Encrypted secrets** for sensitive data
- ✅ **Signed commits** verification
- ✅ **Branch protection** rules
- ✅ **Security scanning** in CI/CD pipeline

### Container Security
- ✅ **Non-root user** execution
- ✅ **Minimal base images** (Alpine/slim)
- ✅ **Vulnerability scanning** with Trivy
- ✅ **Regular security updates**

### Application Security
- ✅ **HTTPS only** in production
- ✅ **Secure headers** (CSP, HSTS, etc.)
- ✅ **Rate limiting** (10 requests/second)
- ✅ **Session security** (HTTPOnly, Secure cookies)

## 🛠️ Troubleshooting

### Common Issues

1. **Deployment fails**
   ```bash
   # Check GitHub Actions logs
   # Verify Coolify webhook is accessible
   # Check container registry permissions
   ```

2. **Health check fails**
   ```bash
   # Check application logs in Coolify
   # Verify /health endpoint is working
   # Check environment variables
   ```

3. **SSL certificate issues**
   ```bash
   # Verify domain DNS records
   # Check Let's Encrypt rate limits
   # Force certificate renewal in Coolify
   ```

### Rollback Procedure

1. **Via Coolify Dashboard:**
   - Go to your application
   - Click on "Deployments"
   - Select previous version
   - Click "Rollback"

2. **Via Git:**
   ```bash
   # Revert to previous commit
   git revert HEAD
   git push origin main
   ```

3. **Via Deployment Script:**
   ```bash
   ./scripts/deploy.sh --rollback
   ```

## 📈 Performance Optimization

### Build Optimization
- **Docker layer caching** for faster builds
- **Multi-platform builds** for ARM64 support
- **Parallel builds** for faster CI/CD

### Runtime Optimization
- **Gunicorn configuration** optimized for production
- **Health checks** with proper timeouts
- **Resource limits** to prevent OOM errors

### Caching Strategy
- **Static file caching** in Nginx
- **Docker layer caching** in CI/CD
- **Browser caching** headers

## 🎉 Benefits Summary

| Feature | Docker Only | GitHub Actions + Coolify |
|---------|-------------|-------------------------|
| **Automated CI/CD** | ❌ Manual | ✅ Automatic |
| **Testing Pipeline** | ❌ None | ✅ Integrated |
| **Security Scanning** | ❌ None | ✅ Trivy scanning |
| **Rollback** | ❌ Manual | ✅ One-click |
| **Monitoring** | ❌ Basic | ✅ Comprehensive |
| **Scaling** | ❌ Manual | ✅ Automatic |
| **SSL Management** | ❌ Manual | ✅ Automatic |
| **Multi-Environment** | ❌ Complex | ✅ Easy |
| **Health Checks** | ❌ Basic | ✅ Advanced |
| **Backups** | ❌ Manual | ✅ Automatic |

## 📞 Support

For issues with:
- **GitHub Actions**: Check GitHub Actions documentation
- **Coolify**: Check Coolify documentation
- **Application**: Check the deployment logs in Coolify dashboard

**Next Steps:**
1. Set up GitHub repository with the provided workflow
2. Configure Coolify with the `coolify.json` file
3. Set up GitHub secrets
4. Test deployment to staging first
5. Deploy to production when ready!