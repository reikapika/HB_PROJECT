from jinja2 import StrictUndefined
import requests
from flask import Flask, render_template, request, jsonify, flash, redirect, session
from flask_debugtoolbar import DebugToolbarExtension
from model import connect_to_db, db, User, Cuisine, Rating, Restaurant, Comment, Bookmark, Popularity
from datetime import datetime
import os
from random import choice


CUISINE = ['Japanese', 'Chinese', 'Korean', 'Indian', 'Vietnamese', 'Thai', 'Middle Eastern']


#Settting up the back end routes.
app = Flask(__name__)

app.secret_key = os.environ.get("SECRET_KEY", "key")
app.jinja_env.undeined = StrictUndefined


APP_ID = os.environ.get('YELP_CONSUMER_KEY')
APP_SECRET = os.environ.get('YELP_CONSUMER_SECRET')
DATA = {'grant_type': 'client_credentials',
        'client_id': APP_ID,
        'client_secret': APP_SECRET}


@app.route("/error")
def error():
    raise Exception("Error!")


@app.route("/")
def index():
    """Homepage."""

    cuisine_id = [1, 2, 3, 4, 5, 6, 7]
    restaurants = []
    for i in range(4):
        cuisine = choice(cuisine_id)
        restaurant = get_sample_restaurant_by_cuisine(cuisine)
        restaurants.append(restaurant)

    return render_template("homepage.html",
                           restaurants=restaurants)


@app.route("/login", methods=['GET', 'POST'])
def login_user():
    """User login."""

    if request.method == 'POST':
        username = request.form["username"]
        password = request.form["password"]
        user = get_user_by_username(username)

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

        exist_user = get_user_by_username(username)
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


@app.route("/logout")
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

    bookmarks = Bookmark.query.filter_by(user_id=user_id).all()
    restaurants = []
    for bookmark in bookmarks:
        restaurant_id = bookmark.restaurant_id
        rest_obj = Restaurant.query.filter_by(restaurant_id=restaurant_id).first()
        restaurants.append(rest_obj)

    return render_template("my_favorite.html", restaurants=restaurants)


@app.route("/remove_favor/<restaurant_id>", methods=['POST'])
def remove_from_favlist(restaurant_id):
    """Removing the restaurant from user's favorite list."""

    bookmark = Bookmark.query.filter_by(restaurant_id=restaurant_id).first()
    db.session.delete(bookmark)
    db.session.commit()
    return redirect("/list_favlist/%s" % session['current_user'])


@app.route("/profile/<user_id>")
def display_profile(user_id):
    """Display profile page for logged in users."""

    if "current_user" in session:
        user = get_user_by_user_id(user_id)
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
    exist_usernames = User.query.filter(User.username.like('%'+user_input+'%')).all()
    exist_restaurants = db.session.query(Restaurant).filter(Restaurant.name.like('%'+user_input+'%')).all()
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
    comments = Comment.query.filter_by(restaurant_id=restaurant_id).all()
    ratings = Rating.query.filter_by(restaurant_id=restaurant_id).all()
    num_likes = exist_rest.num_like_calculator()
    try:
        target = db.session.query(Popularity).filter_by(user_id=session['current_user'], restaurant_id=restaurant_id).first()

        return render_template("restaurant_info.html",
                               rest_info=rest_info,
                               num_likes=num_likes,
                               exist_rest=exist_rest,
                               comments=comments,
                               ratings=ratings,
                               target=target)
    except KeyError:
        target = db.session.query(Popularity).filter_by(restaurant_id=restaurant_id).first()
        return render_template("restaurant_info.html",
                               rest_info=rest_info,
                               num_likes=num_likes,
                               exist_rest=exist_rest,
                               comments=comments,
                               ratings=ratings,
                               target=target)


@app.route("/ratings/<restaurant_id>", methods=['GET'])
def make_rating(restaurant_id):
    """Take User to rating page."""

    return render_template("make_ratings.html",
                           restaurant_id=restaurant_id)


@app.route("/ratings/<restaurant_id>", methods=['POST'])
def post_rating(restaurant_id):
    """Post user's rating by adding to the database."""

    if "current_user" in session:
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
        flash("Your ratings have been added!")
        return redirect("/search_restaurant/%s" % restaurant_id)

    else:
        return render_template("make_ratings.html", restaurant_id=restaurant_id)


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
    flash("Your comments have been added!")
    return redirect("/search_restaurant/%s" % restaurant_id)


@app.route("/remove_comment.json", methods=['POST'])
def remove_comment():
    """Remove a comment."""

    comment_id = request.form['id']
    query = Comment.query.filter_by(comment_id=comment_id).first()
    if query:
        db.session.delete(query)
        db.session.commit()
        return jsonify(status="removed", id=comment_id)
    else:
        return jsonify(status="error")


@app.route("/restaurant_list/<cuisine>", methods=['GET'])
def display_restaurant(cuisine):
    """This lists of all the restaurants of a selected cuisine type."""

    selected_cuisine = Cuisine.query.filter_by(type=cuisine).first()
    results = selected_cuisine.restaurants
    # names = []
    # for i in results:
    #     names.append(i.name)

    return render_template("restaurant_list.html",
                           cuisine=cuisine,
                           results=results)


@app.route("/lookup_cuisine")
def get_restaurant_by_cuisine():
    """List restaurant of user's favorite cuisine."""

    user = get_user_by_user_id(session['current_user'])
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

    #make an api call and instantiate a new restaurant obj.
    if "current_user" in session:
        data = request.form
        name = data.get('name')
        cuisine_name = data.get('cuisine')
        query = Cuisine.query.filter_by(type=cuisine_name).first()
        cuisine_id = query.cuisine_id
        params = {'term': name,
                  'location': 'San Francisco, CA'
                  }

        token = requests.post('https://api.yelp.com/oauth2/token', data=DATA)
        access_token = token.json()['access_token']
        headers = {'Authorization': 'bearer %s' % access_token}
        url = 'https://api.yelp.com/v3/businesses/search'
        resp = requests.get(url=url, params=params, headers=headers)
        rest_info = resp.json()

        #Assuming the first result is what user wants
        adict = rest_info['businesses'][0]

        yelp_id = adict.get('id')
        latitude = adict['coordinates'].get('latitude')
        longitude = adict['coordinates'].get('longitude')
        yelp_rating = adict.get('rating')
        image = adict.get('image_url')

        #check if the restaurant has been added once.
        exist_rest = Restaurant.query.filter_by(yelp_id=yelp_id).first()
        if exist_rest:
            return jsonify(status='exist')

        else:
            #Instantiate new restaurant object to database
            new_restaurant = Restaurant(name=name,
                                        yelp_id=yelp_id,
                                        yelp_rating=yelp_rating,
                                        image=image,
                                        latitude=latitude,
                                        longitude=longitude,
                                        cuisine_id=cuisine_id,
                                        )
            db.session.add(new_restaurant)
            db.session.commit()
            flash("You have successfully added this restaurant!")
            return jsonify(status='success')

    else:
        return jsonify(status='prohibited')


@app.route("/like_rest.json", methods=['POST'])
def increment_numlike():
    """User can like the restaurant and be recorded to our database."""

    if "current_user" in session:
        restaurant_id = request.form['restaurant_id']
        current_user = session['current_user']
        target = db.session.query(Popularity).filter_by(user_id=current_user, restaurant_id=restaurant_id).first()

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


###############################################################################
#Helper functions

def get_sample_restaurant_by_cuisine(cuisine_id):
    """Get one sample restaurant from each cuisine."""

    query = Restaurant.query.filter_by(cuisine_id=cuisine_id).all()
    result = choice(query)
    return result


def get_user_by_user_id(user_id):
    """Get an user object by user_id."""

    query = User.query.filter_by(user_id=user_id).first()

    return query


def get_user_by_username(username):
    """Get an user object by username."""

    query = User.query.filter_by(username=username).first()

    return query


if __name__ == "__main__":

    app.debug = False

    connect_to_db(app, os.environ.get("DATABASE_URL"))

    # Use the DebugToolbar
    DebugToolbarExtension(app)

    DEBUG = "NO_DEBUG" not in os.environ

    PORT = int(os.environ.get("PORT", 5000))

    app.run(host="0.0.0.0", port=PORT, debug=DEBUG)
