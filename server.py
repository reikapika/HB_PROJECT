from jinja2 import StrictUndefined
import requests
# from flask_sqlalchemy import func
from flask import Flask, render_template, request, jsonify, flash, redirect, session
from flask_debugtoolbar import DebugToolbarExtension
from model import connect_to_db, db, User, Cuisine, Rating, Restaurant, Comment, Bookmark, Popularity
from datetime import datetime
import os
from random import choice


CUISINE = ['Japanese', 'Chinese', 'Korean', 'Indian', 'Vietnamese', 'Thai', 'Middle Eastern']


#Settting up the back end routes.
app = Flask(__name__)
app.secret_key = "ABC"
app.jinja_env.undefined = StrictUndefined


APP_ID = os.environ['YELP_CONSUMER_KEY']
APP_SECRET = os.environ['YELP_CONSUMER_SECRET']
DATA = {'grant_type': 'client_credentials',
        'client_id': APP_ID,
        'client_secret': APP_SECRET}


@staticmethod
@app.route("/")
def index():
    """Homepage."""

    if "current_user" in session:
        current_user_id = session["current_user"]
        user = User.query.filter_by(user_id=current_user_id).first()
        restaurant_dict = {'japanese': get_sample_restaurant_by_cuisine(1),
                           'chinese': get_sample_restaurant_by_cuisine(2),
                           'korean': get_sample_restaurant_by_cuisine(3),
                           'indian': get_sample_restaurant_by_cuisine(4),
                           'vietnamese': get_sample_restaurant_by_cuisine(5),
                           'thai': get_sample_restaurant_by_cuisine(6),
                           'middle_east': get_sample_restaurant_by_cuisine(7)
                           }
        lst_of_restaurants = restaurant_dict.values()
        for restaurant in lst_of_restaurants:
            lst_of_comments = get_comments_by_restaurant(restaurant.restaurant_id)

        return render_template("homepage.html",
                               user=user,
                               restaurants=restaurant_dict,
                               comments=lst_of_comments)

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


@app.route("/add_to_favlist.json", methods=['POST'])
def add_to_favorite():
    """Add a restaurant to a user's favorite list."""

    current_user_id = session["current_user"]
    current_rest = request.form.get("restaurant_id")

    if Bookmark.query.filter_by(restaurant_id=current_rest).first():
        return jsonify(status="added", restaurant_id=current_rest)
    else:
        new_favorite = Bookmark(user_id=current_user_id,
                                restaurant_id=current_rest)

        db.session.add(new_favorite)
        db.session.commit()

        return jsonify(status="success", restaurant_id=current_rest)


@app.route("/list_favlist/<user_id>")
def list_favorite(user_id):
    """Listing users' favorite restaurants that they saved before."""

    if "current_user" in session:

        bookmarks = Bookmark.query.filter_by(user_id=user_id).all()
        restaurants = []
        for bookmark in bookmarks:
            restaurant_id = bookmark.restaurant_id
            rest_obj = Restaurant.query.filter_by(restaurant_id=restaurant_id).first()
            restaurants.append(rest_obj)

        return render_template("my_favorite.html", restaurants=restaurants)

    else:

        return redirect("/")


@app.route("/remove_favor/<restaurant_id>", methods=['POST'])
def remove_from_favlist(restaurant_id):
    """Removing the restaurant from user's favorite list."""

    if "current_user" in session:

        bookmark = Bookmark.query.filter_by(restaurant_id=restaurant_id).first()
        db.session.delete(bookmark)
        db.session.commit()
        return redirect("/list_favlist/%s" % session['current_user'])

    else:

        return render_template("login.html")


@app.route("/profile/<user_id>")
def display_profile(user_id):
    """Display profile page for logged in users."""

    if "current_user" in session:
        user = User.query.filter_by(user_id=user_id).first()
        last_login = user.last_login.strftime("%B %d, %Y %M:%S %P")
        membership = user.membership.strftime("%B %d, %Y")
        return render_template("profile.html",
                               user=user,
                               last_login=last_login,
                               membership=membership)
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


@staticmethod
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
    comments = Comment.query.filter_by(restaurant_id=restaurant_id).all()
    num_likes = exist_rest.num_like_calculator()
    target = db.session.query(Popularity).filter_by(user_id=session['current_user'], restaurant_id=restaurant_id).first()

    return render_template("restaurant_info.html",
                           rest_info=rest_info,
                           num_likes=num_likes,
                           exist_rest=exist_rest,
                           comments=comments,
                           target=target)


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
    return redirect("/search_restaurant/%s" % restaurant_id)


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
    return redirect("/search_restaurant/%s" % restaurant_id)


@app.route("/remove_comment.json", methods=['POST'])
def remove_comment():
    """Remove a comment."""

    comment_id = request.form['id']
    query = Comment.query.filter_by(comment_id=comment_id).first()
    db.session.delete(query)
    db.session.commit()

    return jsonify(status="removed")


@app.route("/restaurant_list", methods=['POST'])
def display_restaurant():
    """This lists of all the restaurants of a selected cuisine type."""

    user_input = request.form["cuisine-type"]

    selected_cuisine = Cuisine.query.filter_by(type=user_input).first()
    results = selected_cuisine.restaurants
    names = []
    for i in results:
        names.append(i.name)

    return render_template("restaurant_list.html",
                           cuisine=user_input,
                           results=results)


@staticmethod
@app.route("/lookup_cuisine")
def get_restaurant_by_cuisine():
    """List restaurant of user's favorite cuisine."""

    user = User.query.filter_by(user_id=session['current_user']).first()
    cuisine = Cuisine.query.filter_by(type=user.fav_cuisine).first()
    lookup = Restaurant.query.filter_by(cuisine_id=cuisine.cuisine_id).all()
    cuisine = user.fav_cuisine
    return render_template("lookupcuisine.html",
                           lookup=lookup,
                           cuisine=cuisine)


@app.route("/check_restaurant.json", methods=['POST'])
def lookup_restaurant():
    """User can add a restaurant to the database."""

    if "current_user" in session:
        text = request.form['name']
        print '*********', text
        # lat = request.form.get('lat')
        # lng = request.form.get('lng')
        params = {'term': text,
                  'location': 'San Francisco, CA'
                  }

        token = requests.post('https://api.yelp.com/oauth2/token', data=DATA)
        access_token = token.json()['access_token']
        headers = {'Authorization': 'bearer %s' % access_token}
        url = 'https://api.yelp.com/v3/businesses/search'
        resp = requests.get(url=url, params=params, headers=headers)
        rest_info = resp.json()

        #checking if returned restaurants from search falls into any of my categories
        if rest_info:
            for restaurant in rest_info['businesses']:
                for alias in restaurant['categories']:
                    needle = alias['alias'].title()
                    if needle in CUISINE:
                        return jsonify(status='True', restaurant=restaurant)
                    else:
                        return jsonify(status='Not Found')
        else:
            return jsonify(status='404')
    else:
        return jsonify(status='prohibited')


@app.route("/add_restaurant.json", methods=['POST'])
def add_restaurant():
    """Adding new restaurant upon user request."""

    if "current_user" in session:
        return

    else:
        return jsonify(status='prohibited')


@app.route("/like_rest.json", methods=['POST'])
def increment_numlike():
    """User can like the restaurant and be recorded to our database."""

    if "current_user" in session:
        restaurant_id = request.form['restaurant_id']
        print '********', restaurant_id
        current_user = session['current_user']
        print '********', current_user
        target = db.session.query(Popularity).filter_by(user_id=current_user, restaurant_id=restaurant_id).first()
        print '********', type(target)

        #check if the user has already liked this restaurant
        if target is not None:
            db.session.delete(target)
            db.session.commit()
            num_likes = Popularity.query.filter_by(restaurant_id=restaurant_id).count()
            print '******', num_likes
            return jsonify(status="unliked", num_likes=num_likes)
        else:
            new_like = Popularity(user_id=current_user, restaurant_id=restaurant_id)
            db.session.add(new_like)
            db.session.commit()
            num_likes = new_like.restaurants.num_like_calculator()
            print'*******', num_likes
            return jsonify(status="ok", num_likes=num_likes)
    else:
        flash("Please log in and try again.")
        return redirect("/homepage")


# with app.test_request_context():
#     print url_for('index')
#     print url_for('login')
#     # print url_for('login', next='/')
#     # print url_for('profile', username='John Doe')

###############################################################################
#Helper functions

def get_sample_restaurant_by_cuisine(cuisine_id):
    """Get one sample restaurant from each cuisine."""

    query = Restaurant.query.filter_by(cuisine_id=cuisine_id).all()
    result = choice(query)
    return result


def get_comments_by_restaurant(restaurant_id):
    """Get a random comment for restaurant passed in the parameter."""

    query = Restaurant.query.filter_by(restaurant_id=restaurant_id).first()
    lst_of_comments = query.restaurant
    result = choice(lst_of_comments)
    return result


if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the point
    # that we invoke the DebugToolbarExtension

    # Do not debug for demo
    app.debug = True

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    app.run(host="0.0.0.0")
