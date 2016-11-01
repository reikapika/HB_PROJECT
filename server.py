from flask import Flask, render_template, request, flash, redirect, session
from flask_debugtoolbar import DebugToolbarExtension

#Settting up the back end routes.
app = Flask(__name__)

app.secret_key = "ABC"

app.jinja_env.undefined = StrictUndefined



@app.route("/")
def index():
    """Homepage."""

    return render_template("Homepage.html")

@app.route("/login")
def login():
    """User login."""

    return redirect("main.html")

@app.route("/register")
def register_users():
    """Register new users."""

    return redirect("main.html")

@app.route("/logout")
def logout():
    """Log users out."""

    return render_template("logout.html")

@app.route("/favlist")
def save_restaurants():
    """Takes in users input and save them into their account's favorite list."""

    pass

@app.route("/profile")
def display_profile():
    """Display profile page for logged in users."""

    pass

@app.route("/main")
def display_main():
    """Display main page with top restaurants."""
    """This page will display a list of top 10 resturant names with most likes and comments,
    and display a list of top 10 users being most activate on rating in my site."""

    pass

@app.route("/rating")
def handle_rating():
    """Handling user ratings and save them into database."""

    pass

@app.route("/comments")
def handle_comments():
    """Handling user comments and save them into database."""

    pass

@app.route("/restaurant_info")
def display_restaurant():
    """Display restaurant information and show options of ratings and directions."""

    pass


###############################################################################
if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the point
    # that we invoke the DebugToolbarExtension

    # Do not debug for demo
    app.debug = True

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run()
