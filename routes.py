from flask import Blueprint, render_template, request, redirect, url_for, flash, session

routes = Blueprint("routes", __name__)

@routes.route("/")
def index():
    events = session.get("events", [])
    username = session.get("username")
    return render_template("main.html", events=events, username=username)

@routes.route("/my-tickets")
def my_tickets():
    username = session.get("username")
    if not username:
        flash("Please log in to view your tickets.")
        return redirect(url_for("routes.login"))

    tickets = [
        {"event_name": 'Summer Bash', "date": '2025-06-15', "time": '3 PM', "seat_number": 'A1', "venue_name": 'Liberty Dome', "price": format(51.00, '.2f')},
        {"event_name": 'Rockfest', "date": '2025-07-04', "time": '3 PM', "seat_number": 'A1', "venue_name": 'Sunset Arena', "price": format(51.00, '.2f')}
    ]

    return render_template("my_tickets.html", tickets=tickets, username=username)

@routes.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")

        if username == "guest" and password == "1234":
            session["username"] = username
            flash("Logged in as guest.")
            return redirect(url_for("routes.index"))
        else:
            flash("Invalid username or password.")
            return redirect(url_for("routes.login"))

    return render_template("login.html")

@routes.route("/logout")
def logout():
    session.pop("username", None)
    flash("You have been logged out.")
    return redirect(url_for("routes.index"))

@routes.route("/add-to-cart", methods=["POST"])
def add_to_cart():
    event_id = request.form.get("event_id")
    event_name = request.form.get("event_name")
    price = request.form.get("price")

    if "cart" not in session:
        session["cart"] = []

    session["cart"].append({
        "event_id": event_id,
        "event_name": event_name,
        "price": price
    })

    session.modified = True
    flash(f"{event_name} was added to your cart.")
    return redirect(url_for("routes.index"))

@routes.route("/checkout")
def checkout():
    username = session.get("username")
    if not username:
        flash("Please log in to proceed to checkout.")
        return redirect(url_for("routes.login"))

    cart = session.get("cart", [])
    total = 0.00
    for event in cart:
        total = total + float(event["price"])

    return render_template("checkout.html", cart=cart, username=username, grandTotal=total)

@routes.route("/thank-you")
def thank_you():
    session.pop("cart", None)
    return render_template("thank_you.html")

@routes.route("/complete-purchase", methods=["POST"])
def complete_purchase():
    return redirect(url_for("routes.thank_you"))
