from jinja2 import StrictUndefined
import requests
from flask import Flask, render_template, request, jsonify, flash, redirect, session
from flask_debugtoolbar import DebugToolbarExtension
from model import connect_to_db, db, User, Cuisine, Rating, Restaurant, Comment, Bookmark
from datetime import datetime
import os

#Settting up the back end routes.
app = Flask(__name__)
app.secret_key = "ABC"


APP_ID = os.environ['YELP_CONSUMER_KEY']
APP_SECRET = os.environ['YELP_CONSUMER_SECRET']
DATA = {'grant_type': 'client_credentials',
        'client_id': APP_ID,
        'client_secret': APP_SECRET}


@app.route("/")
def index():
    """Homepage."""

    if "current_user" in session:
        current_user_id = session["current_user"]
        user = User.query.filter_by(user_id=current_user_id).first()
        return render_template("homepage.html", user=user)
    else:
        return render_template("homepage.html")


@app.route("/login", methods=['GET', 'POST'])
def login_user():
    """User login."""

    if request.method == 'POST':
        username = request.form["username"]
        password = request.form["password"]
        user = User.query.filter_by(username=username).first()
        if not user:
            flash("User does not exist.")
            return redirect("/")
        if user.password != password:
            flash("Incorrect password, please try again.")
            return redirect("/login")

        session["current_user"] = user.user_id
        user.last_login = datetime.utcnow()
        db.session.commit()

        flash("You are now logged in.")

        return redirect("/profile/%s" % user.username)

    return render_template("login.html")


@app.route("/register", methods=['GET', 'POST'])
def register_users():
    """Register new users."""

    if request.method == 'POST':
        username = request.form["username"]
        fav_cuisine = request.form["fav-cuisine"]
        fname = request.form["fname"]
        lname = request.form["lname"]
        password = request.form["password"]
        membership = datetime.datetime.utcnow()
        last_login = datetime.datetime.utcnow()

        exist_user = User.query.filter_by(username=username).first()
        if exist_user is None:
            new_user = User(username=username,
                            password=password,
                            fname=fname,
                            lname=lname,
                            fav_cuisine=fav_cuisine,
                            membership=membership,
                            last_login=last_login
                            )
            db.session.add(new_user)
            db.session.commit()

        flash("Welcome, %s!" % fname)
        return redirect("/profile/%s" % new_user.username)

    return render_template("register.html")


@app.route("/logout", methods=['POST'])
def logout():
    """Log users out."""

    session.pop('current_user', None)
    flash('You were logged out')

    return redirect("/")


@app.route("/see_favlist", methods=['GET'])
def get_favorite_restaurants():
    """Takes in users input and save them into their account's favorite list."""

    return render_template("my_favorite.html")


@app.route("/add_to_favlist", methods=['POST'])
def add_to_favorite():
    """Add a restaurant to a user's favorite list."""

    if "current_user" in session:
        current_user_id = session["current_user"]
        current_rest = request.form['restaurant']
        print '************', current_rest
        query = Restaurant.query.filter_by(name=current_rest).first()
        print '*******', query
        new_favorite = Bookmark(user_id=current_user_id,
                                restaurant_id=query.restaurant_id)
        print '************', new_favorite
        db.session.add(new_favorite)
        db.session.commit()
        return redirect("/")
    else:
        return render_template("invalid_page.html")


@app.route("/list_favlist")
def list_favorite():
    """Listing users' favorite restaurants that they saved before."""
    pass
    # if "current_user" in session:
    #     favorite = User.query(Restaurant.)


@app.route("/profile/<username>")
def display_profile(username):
    """Display profile page for logged in users."""

    if "current_user" in session:
        user = User.query.filter_by(username=username).first()
        return render_template("profile.html", user=user)
    else:
        return render_template("invalid_page.html")


# @app.route("/main")
# def display_main():
#     """Display main page with top restaurants."""
#     """This page will display a list of top 10 resturant names with most likes and comments,
#     and display a list of top 10 users being most activate on rating in my site."""

#     pass


@app.route("/search", methods=['POST'])
def search_restaurant():
    """This allows users to search restaurant and lead them to the restaurant_info page."""

    user_input = request.form["search-form"]
    exist_usernames = [t for t in db.session.query(User.username).all()]
    exist_restaurants = [t for t in db.session.query(Restaurant.name).all()]

    if (user_input,) in exist_usernames:
        # if exist_user is not None:
        #     print '**********', exist_user
        exist_user = User.query.filter_by(username=user_input).first()
        return redirect("/profile/%s" % exist_user.username)

    else:
        if (user_input,) in exist_restaurants:
            exist_rest = Restaurant.query.filter_by(name=user_input).first()
            if user_input == exist_rest.name:
                rest_name = exist_rest.name
                token = requests.post('https://api.yelp.com/oauth2/token', data=DATA)
                access_token = token.json()['access_token']
                headers = {'Authorization': 'bearer %s' % access_token}
                url = "https://api.yelp.com/v3/businesses/"
                resp = requests.get(url=url+exist_rest.yelp_id, headers=headers)
                rest_info = resp.json()
                num_likes = Restaurant.query.filter_by(name=rest_info['name']).first()
                num_likes = num_likes.num_like_calculator()
                return render_template("restaurant_info.html",
                                       rest_info=rest_info,
                                       num_likes=num_likes)
        else:

            flash("Sorry, I don't understand you. Please try again")
            return redirect("/")


@app.route("/ratings", methods=['GET', 'POST'])
def handle_rating():
    """Handling user ratings and save them into database."""

    if request.method == 'POST':
        input_rest = request.form["restaurant"]
        cleanliness = request.form["rating1"]
        quality = request.form["rating2"]
        atmosphere = request.form["rating3"]
        consistency = request.form["rating4"]
        input_rest_id = Restaurant.query.filter_by(name=input_rest).first()
        new_ratings = Rating(user_id=session["current_user"],
                             restaurant_id=input_rest_id.restaurant_id,
                             cleanliness=cleanliness,
                             quality=quality,
                             atmosphere=atmosphere,
                             consistency=consistency,
                             )
        db.session.add(new_ratings)
        db.session.commit()
        flash("You're ratings have been added!")
        return redirect("/")
    else:
        return render_template("make_ratings.html")


@app.route("/comments", methods=['GET', 'POST'])
def handle_comments():
    """Handling user comments and save them into database."""

    if request.method == 'POST':
        input_rest = request.form["restaurant"]
        text = request.form["user-comment"]
        input_rest_id = Restaurant.query.filter_by(name=input_rest).first()
        new_comment = Comment(user_id=session["current_user"],
                              restaurant_id=input_rest_id.restaurant_id,
                              comment=text,
                              )
        db.session.add(new_comment)
        db.session.commit()
        return redirect("/")
    else:
        return render_template("make_comments.html")


@app.route("/restaurant_list", methods=['POST'])
def display_restaurant():
    """This lists of all the restaurants of a selected cuisine type."""

    user_input = request.form["cuisine-type"]

    selected_cuisine = Cuisine.query.filter_by(type=user_input).first()
    results = [restaurant.name for restaurant in selected_cuisine.restaurants]

    return render_template("restaurant_list.html", results=results)


@app.route("/like_rest", methods=['POST'])
def increment_numlike():
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
    app.jinja_env.undefined = StrictUndefined

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run(host="0.0.0.0")
