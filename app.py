# app.py (UI + temporary backend entrypoint)
# Created for UI testing and demonstration purposes
# Team may use this as a reference or starting point

from flask import Flask, session
from routes import routes

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Needed for session management

from database import db
db.init_app(app)

# Temporary data for events
app.config['EVENTS'] = [
    {"id": 1, "name": "Overwatch Invitational", "date": "July 30, 2025", "time": "3 PM", "tickets_available": 0, "price": 45},
    {"id": 2, "name": "MLS Match: NYCFC vs LA Galaxy", "date": "July 31, 2025", "time": "7:30 PM", "tickets_available": 150, "price": 55},
    {"id": 3, "name": "NBA Summer League: Knicks vs Bulls", "date": "August 1, 2025", "time": "6 PM", "tickets_available": 120, "price": 40},
    {"id": 4, "name": "Rock the River Music Festival", "date": "August 3, 2025", "time": "1 PM", "tickets_available": 0, "price": 35}
]

# Stores temporary events into the session before each request
@app.before_request
def load_events():
    session['events'] = app.config['EVENTS']

# Register all routes from the Blueprint
app.register_blueprint(routes)

if __name__ == "__main__":
    app.run(debug=True)
