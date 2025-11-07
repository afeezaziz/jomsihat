from flask import Flask, render_template, session, request, redirect, url_for
import os
import json

app = Flask(__name__, template_folder='app/templates', static_folder='app/static')
app.secret_key = 'your-secret-key-change-in-production'

# Language and translation functions
def load_translations():
    translations = {}
    try:
        with open('app/translations.json', 'r', encoding='utf-8') as f:
            translations = json.load(f)
    except FileNotFoundError:
        translations = {
            'en': {'hello': 'Hello', 'welcome': 'Welcome'},
            'ms': {'hello': 'Helo', 'welcome': 'Selamat datang'}
        }
    return translations

def get_text(key, language='en'):
    translations = load_translations()
    return translations.get(language, {}).get(key, key)

@app.context_processor
def inject_translations():
    def t(key):
        language = session.get('language', 'en')
        return get_text(key, language)
    return dict(t=t, current_language=session.get('language', 'en'))

@app.route('/set_language/<language>')
def set_language(language):
    if language in ['en', 'ms']:
        session['language'] = language
    return redirect(request.referrer or url_for('index'))

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/services')
def services():
    return render_template('services.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/nutrition')
def nutrition():
    return render_template('nutrition.html')

@app.route('/workout')
def workout():
    return render_template('workout.html')

if __name__ == '__main__':
    app.run(debug=True)