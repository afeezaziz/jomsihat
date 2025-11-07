# 🇲🇾 Jom Sihat - Malaysian Fitness & Health Platform

A vibrant, colorful fitness and health platform designed for Malaysians, built with Flask and Tailwind CSS. Features bilingual support (English/Malay) and modern web technologies.

## ✨ Features

### 🎨 Design & User Experience
- **🇲🇾 Malaysian Theme**: Colors inspired by the Malaysian flag
- **🌈 Vibrant Colors**: Energetic gradients for fitness motivation
- **📱 Responsive Design**: Works perfectly on all devices
- **🎯 Fitness-Focused**: Modern, athletic design aesthetic
- **🌴 Tropical Considerations**: Designed for Malaysian climate

### 🌐 Multi-Language Support
- **🇬🇧 English**: Full English language support
- **🇲🇾 Bahasa Melayu**: Complete Malay language support
- **🔄 Easy Switching**: Simple language toggle in navigation
- **📝 Extensive Translations**: All UI text fully translated

### 🍎 Nutrition Module
- **🥗 Balanced Diet Plans**: Malaysian food pyramid integration
- **📅 Meal Planning**: Weekly meal schedules
- **👨‍⚕️ Nutrition Counseling**: Professional guidance
- **⚖️ Weight Management**: Science-based approaches
- **🏃‍♂️ Sports Nutrition**: Athlete-specific programs
- **💊 Supplement Guidance**: Safe and effective recommendations

### 💪 Workout Module
- **🏋️‍♀️ Strength Training**: Weights and resistance training
- **👥 Group Classes**: Zumba, Body Combat, Dance Fitness
- **🏃‍♂️ Cardio Fitness**: Treadmill, cycling, HIIT
- **🧘‍♀️ Flexibility & Yoga**: Balance and mobility
- **👨‍⚕️ Personal Training**: One-on-one coaching
- **🏥 Rehabilitation**: Injury recovery programs

### 🇲🇾 Malaysian Features
- **🥘 Local Foods**: Nasi Lemak Power Bowl, Satay, etc.
- **🥋 Traditional Fitness**: Silat, Tomoi, Malaysian sports
- **🌴 Tropical Adaptation**: Weather-appropriate exercises
- **🏛️ Cultural Elements**: Heritage-inspired workouts
- **🤝 Community Focus**: Malaysian togetherness spirit

## 🚀 Quick Start

### Local Development
```bash
# Clone the repository
git clone https://github.com/afeezaziz/jomsihat.git
cd jomsihat

# Install dependencies
pip install -r requirements.txt

# Run the application
python app.py

# Visit http://localhost:5000
```

### Docker Deployment
```bash
# Build and run with Docker
docker build -t jomsihat .
docker run -p 5000:5000 jomsihat

# Or use Docker Compose
docker-compose up -d
```

### Coolify + GitHub Repository Deployment
```bash
# Push to GitHub - Coolify builds automatically!
git add .
git commit -m "Update for deployment"
git push origin main

# Coolify will auto-build and deploy from your Dockerfile
# Repository: https://github.com/afeezaziz/jomsihat.git
# Branch: main
# Port: 5000
# Health Check: /health
```

## 📁 Project Structure

```
jomsihat/
├── app/
│   ├── templates/          # HTML templates
│   │   ├── base.html      # Base template with navigation
│   │   ├── index.html     # Homepage with Malaysian theme
│   │   ├── nutrition.html # Nutrition module
│   │   ├── workout.html   # Workout module
│   │   ├── about.html     # About page
│   │   ├── services.html  # Services page
│   │   └── contact.html   # Contact page
│   ├── static/
│   │   ├── css/           # Stylesheets
│   │   ├── js/            # JavaScript files
│   │   └── images/        # Image assets
│   └── translations.json  # Language translations
├── tests/                 # Test suite
├── scripts/               # Utility scripts
├── nginx/                 # Nginx configuration
├── app.py                 # Main Flask application
├── requirements.txt       # Python dependencies
├── Dockerfile            # Docker configuration
├── docker-compose.yml    # Docker Compose setup
├── coolify.json         # Coolify configuration
├── COOLIFY_SETUP.md     # Coolify setup guide
└── README.md             # This file
```

## 🛠️ Technologies Used

### Backend
- **Flask 3.0**: Python web framework
- **Gunicorn**: Production WSGI server
- **Python 3.11**: Modern Python version
- **JSON**: Language translation system

### Frontend
- **Tailwind CSS**: Utility-first CSS framework
- **HTML5**: Semantic markup
- **JavaScript**: Interactive features
- **Google Fonts**: Bebas Neue & Inter typography

### DevOps & Deployment
- **Docker**: Containerization
- **GitHub**: Source code repository
- **Coolify**: Build and deployment platform
- **Nginx**: Reverse proxy (optional)

## 🌐 Pages & Routes

| Route | Page | Description |
|-------|------|-------------|
| `/` | Home | Hero section with Malaysian fitness theme |
| `/about` | About | Mission and company information |
| `/services` | Services | Complete healthcare services list |
| `/nutrition` | Nutrition | Malaysian nutrition and diet programs |
| `/workout` | Workout | Fitness and exercise programs |
| `/contact` | Contact | Contact form and location details |
| `/health` | Health Check | API health check endpoint |

## 🎨 Design System

### Color Palette
- **Blue** (`#014E82`): Trust, healthcare
- **Yellow** (`#FFCC00`): Energy, happiness
- **Red** (`#DC143C`): Passion, fitness
- **Green** (`#4facfe`): Health, nature
- **Purple** (`#764ba2`): Wellness, luxury

### Typography
- **Bebas Neue**: Headers, emphasis text
- **Inter**: Body text, UI elements

### Gradients
- **Malaysian Flag**: Blue → Yellow → Red
- **Energy**: Pink → Purple gradients
- **Nature**: Blue → Cyan gradients
- **Fitness**: Orange → Red gradients

## 🌍 Language Support

### Implemented Languages
- **English** (Default): Full translation coverage
- **Bahasa Melayu**: Complete Malaysian language support

### Adding New Languages
1. Add language code to `app.py` set_language route
2. Add translations to `translations.json`
3. Update language selector in templates

## 🐳 Docker Deployment

### Build Image
```bash
# Build for production
docker build -t afeezaziz/jomsihat:latest .

# Multi-platform build
docker buildx build --platform linux/amd64,linux/arm64 -t afeezaziz/jomsihat:latest .
```

### Run Container
```bash
# Basic run
docker run -d -p 5000:5000 afeezaziz/jomsihat:latest

# With environment variables
docker run -d -p 5000:5000 \
  -e SECRET_KEY=your-secret-key \
  -e FLASK_ENV=production \
  afeezaziz/jomsihat:latest
```

### Coolify Deployment
```bash
# Simply push to GitHub - Coolify builds automatically!
git add .
git commit -m "Ready for deployment"
git push origin main

# Coolify will:
# 1. Clone your repository
# 2. Build using Dockerfile
# 3. Deploy automatically
# 4. Monitor health
```

## 🔧 Configuration

### Environment Variables
| Variable | Description | Default |
|----------|-------------|---------|
| `FLASK_ENV` | Flask environment | `development` |
| `FLASK_APP` | Flask app module | `app.py` |
| `SECRET_KEY` | Session encryption | Required |
| `HOST` | Host to bind to | `0.0.0.0` |
| `PORT` | Port to listen on | `5000` |

### Coolify Configuration
See `coolify.json` for complete Coolify setup
- **Repository**: `https://github.com/afeezaziz/jomsihat.git`
- **Branch**: `main` (or `develop` for staging)
- **Port**: `5000`
- **Health Check**: `/health`
- **Auto-build**: Enabled (on git push)

## 🧪 Testing

### Run Tests
```bash
# Install test dependencies
pip install pytest Flask-Testing

# Run all tests
python -m pytest tests/ -v

# Run specific test file
python -m pytest tests/test_app.py -v

# Run with coverage
python -m pytest tests/ -v --cov=app
```

### Test Coverage
- Route testing
- Health check validation
- Language switching functionality
- Translation system validation
- Error handling verification

## 🔒 Security

### Features
- **Non-root user** in containers
- **Secure session cookies**
- **Input validation**
- **HTTPS ready** (configure in production)
- **Environment variable** configuration

### Best Practices
- Use strong `SECRET_KEY` in production
- Enable HTTPS in Coolify
- Regular dependency updates
- Monitor Docker Hub for security updates

## 📊 Monitoring

### Health Check
- **Endpoint**: `/health`
- **Response**: JSON with status, version, language
- **Method**: GET

### Coolify Monitoring
- Built-in health checks
- Resource usage monitoring
- Deployment status tracking
- Log aggregation

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new features
5. Run the test suite
6. Commit your changes
7. Push to the branch
8. Create a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/afeezaziz/jomsihat/issues)
- **GitHub Repository**: [afeezaziz/jomsihat](https://github.com/afeezaziz/jomsihat)
- **Documentation**: [COOLIFY_SETUP.md](COOLIFY_SETUP.md)

## 🎉 Acknowledgments

- **Flask** - The web framework
- **Tailwind CSS** - The CSS framework
- **Coolify** - Build and deployment platform
- **Docker** - Containerization
- **GitHub** - Source code repository
- **Malaysian Community** - Inspiration and cultural references

---

**Made with ❤️ in Malaysia for Malaysians** 🇲🇾

**GitHub Repository**: https://github.com/afeezaziz/jomsihat
**Live Demo**: Deploy using Coolify with GitHub repository `afeezaziz/jomsihat`