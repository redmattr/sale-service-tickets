# app.py (UI + temporary backend)
# Created for UI testing and demonstration purposes
# Team may use this as a reference or starting point

from flask import Flask, render_template, request, redirect, url_for, flash, session

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Needed for flashing messages and session handling

# Mock users
users = {
    "user1": "pass1",
    "vendor": "vendorpass"
}

# Mock data for events
events = [
    {"id": 1, "name": "Overwatch Invitational", "date": "July 30, 2025", "time": "3 PM", "tickets_available": 0, "price": 45},
    {"id": 2, "name": "MLS Match: NYCFC vs LA Galaxy", "date": "July 31, 2025", "time": "7:30 PM", "tickets_available": 150, "price": 55},
    {"id": 3, "name": "NBA Summer League: Knicks vs Bulls", "date": "August 1, 2025", "time": "6 PM", "tickets_available": 120, "price": 40},
    {"id": 4, "name": "Rock the River Music Festival", "date": "August 3, 2025", "time": "1 PM", "tickets_available": 0, "price": 35}
]

@app.route("/")
def index():
    username = session.get("username")
    return render_template("main.html", events=events, username=username)

@app.route("/purchase", methods=["POST"])
def purchase():
    event_id = request.form.get("event_id")
    event_name = request.form.get("event_name")
    price = request.form.get("price")

    if event_name and price:
        return render_template("confirmation.html", event_name=event_name, price=price)
    else:
        flash("Something went wrong with the purchase.")
        return redirect(url_for("index"))

@app.route("/my-tickets")
def my_tickets():
    username = session.get("username")
    if not username:
        flash("Please log in to view your tickets.")
        return redirect(url_for("login"))

    # Temporary ticket data
    tickets = [
        {
            "event_name": "NBA Summer League",
            "date": "August 1, 2025",
            "time": "6 PM",
            "seat_number": "B12",
            "venue_name": "MSG",
            "price": 40
        },
        {
            "event_name": "Rock the River Festival",
            "date": "August 3, 2025",
            "time": "1 PM",
            "seat_number": "GA",
            "venue_name": "Riverfront",
            "price": 35
        }
    ]
    return render_template("my_tickets.html", tickets=tickets, username=username)

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")

        # Guest User
        if username == "guest" and password == "1234":
            session["username"] = username
            flash("Logged in as guest.")
            return redirect(url_for("index"))
        else:
            flash("Invalid username or password.")
            return redirect(url_for("login"))

    return render_template("login.html")


@app.route("/logout")
def logout():
    session.pop("username", None)
    flash("You have been logged out.")
    return redirect(url_for("index"))

if __name__ == "__main__":
    app.run(debug=True)
