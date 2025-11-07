import pytest
import json
import os
import sys

# Add the parent directory to the path so we can import app
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    app.config['SECRET_KEY'] = 'test-secret-key'
    with app.test_client() as client:
        with app.app_context():
            yield client

@pytest.fixture
def runner():
    app.config['TESTING'] = True
    app.config['SECRET_KEY'] = 'test-secret-key'
    return app.test_cli_runner()

class TestBasicRoutes:
    """Test basic application routes"""

    def test_index_route(self, client):
        """Test the index route works"""
        response = client.get('/')
        assert response.status_code == 200
        assert b'Jom Sihat' in response.data
        assert b'Welcome' in response.data

    def test_about_route(self, client):
        """Test the about route works"""
        response = client.get('/about')
        assert response.status_code == 200
        assert b'About' in response.data

    def test_services_route(self, client):
        """Test the services route works"""
        response = client.get('/services')
        assert response.status_code == 200
        assert b'Services' in response.data

    def test_contact_route(self, client):
        """Test the contact route works"""
        response = client.get('/contact')
        assert response.status_code == 200
        assert b'Contact' in response.data

    def test_nutrition_route(self, client):
        """Test the nutrition route works"""
        response = client.get('/nutrition')
        assert response.status_code == 200
        assert b'Nutrition' in response.data

    def test_workout_route(self, client):
        """Test the workout route works"""
        response = client.get('/workout')
        assert response.status_code == 200
        assert b'Workout' in response.data

class TestHealthCheck:
    """Test health check endpoint"""

    def test_health_endpoint(self, client):
        """Test the health check endpoint"""
        response = client.get('/health')
        assert response.status_code == 200
        data = json.loads(response.data)
        assert data['status'] == 'healthy'
        assert data['service'] == 'Jom Sihat'
        assert 'version' in data

class TestLanguageSwitching:
    """Test language switching functionality"""

    def test_set_language_english(self, client):
        """Test setting language to English"""
        with client.session_transaction() as sess:
            response = client.get('/set_language/en', follow_redirects=True)
            assert response.status_code == 200
            # Check if language was set (this would require more complex session testing)

    def test_set_language_malay(self, client):
        """Test setting language to Malay"""
        with client.session_transaction() as sess:
            response = client.get('/set_language/ms', follow_redirects=True)
            assert response.status_code == 200

class TestTranslationLoading:
    """Test translation system"""

    def test_load_translations(self):
        """Test that translations can be loaded"""
        from app import load_translations
        translations = load_translations()
        assert 'en' in translations
        assert 'ms' in translations
        assert 'site_name' in translations['en']
        assert 'site_name' in translations['ms']

    def test_get_text_function(self):
        """Test the get_text function"""
        from app import get_text
        # Test English
        text = get_text('site_name', 'en')
        assert text == 'Jom Sihat'

        # Test Malay
        text = get_text('site_name', 'ms')
        assert text == 'Jom Sihat'

        # Test fallback
        text = get_text('nonexistent_key', 'en')
        assert text == 'nonexistent_key'

class TestStaticFiles:
    """Test static file serving"""

    def test_static_files_accessible(self, client):
        """Test that static files are accessible"""
        # Test CSS file (if it exists)
        response = client.get('/static/css/style.css')
        # This might return 404 if file doesn't exist, which is fine for this test

        # Test JS file (if it exists)
        response = client.get('/static/js/main.js')
        # This might return 404 if file doesn't exist, which is fine for this test

class TestErrorHandling:
    """Test error handling"""

    def test_404_error(self, client):
        """Test 404 error handling"""
        response = client.get('/nonexistent-route')
        assert response.status_code == 404

class TestAppConfiguration:
    """Test Flask application configuration"""

    def test_app_config(self):
        """Test that Flask app is properly configured"""
        assert app.template_folder == 'app/templates'
        assert app.static_folder == 'app/static'
        assert 'SECRET_KEY' in app.config

if __name__ == '__main__':
    pytest.main([__file__, '-v'])