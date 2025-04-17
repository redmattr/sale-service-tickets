# app.py (UI + temporary backend entrypoint)
# Created for UI testing and demonstration purposes
# Team may use this as a reference or starting point

from flask import Flask, session
from routes import routes
from eventBuild import eventBuilder

app = Flask(__name__)
app.config['DATABASE'] = 'database/pyDB.db'
app.secret_key = 'your_secret_key'  # Needed for session management

# Imports and initializes database from the database folder
from database import db
db.init_app(app)

# Stores temporary events into the session before each request
@app.before_request
def load_events():
    session['events'] = app.config['EVENTS']

def ticketFinder(row, ticketRows):
    for tickets in ticketRows:
        if row[4] == tickets[5]:
            return tickets[3]

eventList = []

def eventLoad():
    # Temporary data for events

    with app.app_context():
        data = db.get_db()
        cursor = data.cursor()
        cursor.execute("SELECT * FROM events")
        eventRows = cursor.fetchall()
        cursor.execute("SELECT * FROM tickets")
        ticketRows = cursor.fetchall()

        for row in eventRows:
            newEvent = eventBuilder(row[4], row[1], row[2], row[3], '3 PM', 5, format(ticketFinder(row, ticketRows), '.2f'))
            eventList.append(newEvent)

eventLoad()

newList = []

for event in eventList:
    newList.append(event.makeSerializable())

app.config['EVENTS'] = newList

# Register all routes from the Blueprint
app.register_blueprint(routes)

if __name__ == "__main__":
    app.run(debug=True)
