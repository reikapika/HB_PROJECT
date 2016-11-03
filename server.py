from jinja2 import StrictUndefined
from flask import Flask, render_template, request, flash, redirect, session
from flask_debugtoolbar import DebugToolbarExtension
from model import connect_to_db, db, User, Cuisine, Rating, Restaurant, Comment, Bookmark

#Settting up the back end routes.
app = Flask(__name__)
app.secret_key = "ABC"
app.jinja_env.undefined = StrictUndefined


@app.route("/")
def index():
    """Homepage."""

    return render_template("homepage.html")


@app.route("/login", methods=['GET', 'POST'])
def login():
    """User login."""

    if request.method == 'POST':
        username = request.form["username"]
        password = request.form["password"]
        user = User.query.filter_by(username=username).first()
        if not user:
            flash("User does not exist.")
            return redirect("/profile/<int:user_id>")
        if user.password != password:
            flash("Incorrect password, please try again.")
            return redirect("/login")

        session["user_id"] = user.user_id
        flash("You are now logged in.")

        return redirect("/profile/%s" % user.user_id)

    return render_template("login.html")


@app.route("/register", methods=['POST'])
def register_users():
    """Register new users."""


    return redirect("main.html")


@app.route("/logout")
def logout():
    """Log users out."""

    session.pop('logged_in', None)
    flash('You were logged out')

    return redirect("/")


@app.route("/favlist")
def save_restaurants():
    """Takes in users input and save them into their account's favorite list."""

    pass


@app.route("/profile/<int:user_id>")
def display_profile(user_id):
    """Display profile page for logged in users."""

    user = User.query.get(user_id)
    return render_template("profile.html", user=user)


@app.route("/main")
def display_main():
    """Display main page with top restaurants."""
    """This page will display a list of top 10 resturant names with most likes and comments,
    and display a list of top 10 users being most activate on rating in my site."""

    pass


@app.route("/search-rest")
def search_restaurant():
    """This allows users to search restaurant and lead them to the restaurant_info page."""

    pass


@app.route("/search-user")
def search_user():
    """This lets user to look up other users and their profile page (logged in users only)."""

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


@app.route("/map")
def show_map():
    """Allow users to get the directional info from Google Map."""
    pass


# with app.test_request_context():
#     print url_for('index')
#     print url_for('login')
#     # print url_for('login', next='/')
#     # print url_for('profile', username='John Doe')

###############################################################################
if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the point
    # that we invoke the DebugToolbarExtension

    # Do not debug for demo
    app.debug = True

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run(host='0.0.0.0')
