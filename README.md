# Jom Sihat Website

A Flask-based healthcare website built with Tailwind CSS for the Jom Sihat healthcare service.

## Features

- Responsive design with Tailwind CSS
- Multiple pages: Home, About, Services, Contact
- Clean and modern healthcare-focused UI
- Mobile-friendly navigation

## Setup Instructions

### 1. Install Python Dependencies

```bash
pip install -r requirements.txt
```

### 2. Install Node.js Dependencies (for Tailwind CSS compilation)

```bash
npm install
```

### 3. Run the Flask Application

```bash
python app.py
```

The application will be available at `http://localhost:5000`

### 4. (Optional) Build Tailwind CSS for Production

If you want to use the custom Tailwind build instead of the CDN:

```bash
npm run build-css
```

Then update the base.html template to use the local CSS file instead of the CDN.

## Project Structure

```
jomsihat/
├── app/
│   ├── templates/
│   │   ├── base.html
│   │   ├── index.html
│   │   ├── about.html
│   │   ├── services.html
│   │   └── contact.html
│   └── static/
│       ├── css/
│       │   └── input.css
│       ├── js/
│       │   └── main.js
│       └── images/
├── app.py
├── requirements.txt
├── package.json
├── tailwind.config.js
├── postcss.config.js
└── README.md
```

## Pages

- **Home (`/`)**: Landing page with hero section and service highlights
- **About (`/about`)**: Information about Jom Sihat and mission
- **Services (`/services`)**: List of healthcare services offered
- **Contact (`/contact`)**: Contact form and location information

## Technologies Used

- **Flask**: Python web framework
- **Tailwind CSS**: Utility-first CSS framework
- **HTML5**: Semantic markup
- **JavaScript**: Interactive features

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the application
5. Submit a pull request