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

        return redirect("/profile/%s" % user.user_id)

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
        membership = datetime.utcnow()
        last_login = datetime.utcnow()

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

        else:
            print '*******Already exists.******'
            return render_template('/login.html')

        flash("Welcome, %s!" % fname)
        return redirect("/profile/%s" % new_user.user_id)

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
        current_rest = request.form.get("yelp-id")
        print '************', current_rest
        query = Restaurant.query.filter_by(yelp_id=current_rest).first()
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


@app.route("/profile/<user_id>")
def display_profile(user_id):
    """Display profile page for logged in users."""

    if "current_user" in session:
        user = User.query.filter_by(user_id=user_id).first()
        return render_template("profile.html", user=user)
    else:
        return render_template("login.html")


@app.route("/search", methods=['POST'])
def do_search():
    """This allows users to search restaurant and lead them to the restaurant_info page."""

    user_input = request.form["search-form"]
    exist_usernames = User.query.filter(User.username.like('%' + user_input + '%')).all()
    exist_restaurants = Restaurant.query.filter(Restaurant.name.like('%' + user_input + '%')).all()
    return render_template("search_result.html",
                           exist_usernames=exist_usernames,
                           exist_restaurants=exist_restaurants)


@app.route("/search_restaurant/<restaurant_id>", methods=['GET'])
def call_yelp(restaurant_id):
    """Make an api call for selected restaurant."""

    exist_rest = Restaurant.query.filter_by(restaurant_id=restaurant_id).first()
    token = requests.post('https://api.yelp.com/oauth2/token', data=DATA)
    access_token = token.json()['access_token']
    headers = {'Authorization': 'bearer %s' % access_token}
    url = "https://api.yelp.com/v3/businesses/"
    resp = requests.get(url=url+exist_rest.yelp_id, headers=headers)
    rest_info = resp.json()
    num_likes = exist_rest.num_like_calculator()

    return render_template("restaurant_info.html",
                           rest_info=rest_info,
                           num_likes=num_likes,
                           exist_rest=exist_rest)


@app.route("/ratings/<restaurant_id>", methods=['GET'])
def make_rating(restaurant_id):
    """Take User to rating page."""

    return render_template("make_ratings.html",
                           restaurant_id=restaurant_id)


@app.route("/ratings/<restaurant_id>", methods=['POST'])
def post_rating(restaurant_id):
    """Post user's rating by adding to the database."""

    cleanliness = request.form["rating1"]
    quality = request.form["rating2"]
    atmosphere = request.form["rating3"]
    consistency = request.form["rating4"]
    new_ratings = Rating(user_id=session["current_user"],
                         restaurant_id=restaurant_id,
                         cleanliness=cleanliness,
                         quality=quality,
                         atmosphere=atmosphere,
                         consistency=consistency,
                         )
    db.session.add(new_ratings)
    db.session.commit()
    flash("You're ratings have been added!")
    return redirect("/")


@app.route("/comments/<restaurant_id>", methods=['GET'])
def make_comments(restaurant_id):
    """Take user to comments page."""

    return render_template("make_comments.html",
                           restaurant_id=restaurant_id)


@app.route("/comments/<restaurant_id>", methods=['POST'])
def post_comments(restaurant_id):
    """Add a user comment to the restaurant."""

    text = request.form["user-comment"]
    new_comment = Comment(user_id=session["current_user"],
                          restaurant_id=restaurant_id,
                          comment=text,
                          )
    db.session.add(new_comment)
    db.session.commit()
    return redirect("/")


@app.route("/restaurant_list", methods=['POST'])
def display_restaurant():
    """This lists of all the restaurants of a selected cuisine type."""

    user_input = request.form["cuisine-type"]

    selected_cuisine = Cuisine.query.filter_by(type=user_input).first()
    results = selected_cuisine.restaurants

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
