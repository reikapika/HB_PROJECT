from flask_sqlalchemy import SQLAlchemy


db = SQLAlchemy()

#Model definition


class Cuisine(db.Model):
    """Cuisine types of Pocket Asia"""

    __tablename__ = 'cuisine'

    cuisine_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    type = db.Column(db.String(40), nullable=False)

    #Defining relationship with restaurants table
    restaurants = db.relationship('Restaurant', backref='cuisine')


class Restaurant(db.Model):
    """Restaurants"""

    __tablename__ = 'restaurants'

    restaurant_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(50), nullable=False)
    yelp_id = db.Column(db.String(100), nullable=False)
    yelp_rating = db.Column(db.Integer, nullable=False)
    latitude = db.Column(db.Float, nullable=False)
    longitude = db.Column(db.Float, nullable=False)
    num_like = db.Column(db.Integer, nullable=True)
    cuisine_id = db.Column(db.Integer, db.ForeignKey('cuisine.cuisine_id'))

    #Defining relationship with comments and ratings table

    ratings = db.relationship('Rating', backref='restaurant')


class User(db.Model):
    """Users of Pocket Asia."""

    __tablename__ = 'users'

    user_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(50), nullable=False, unique=True)
    password = db.Column(db.String(65), nullable=False)
    fname = db.Column(db.String(50), nullable=True)
    lname = db.Column(db.String(50), nullable=True)
    fav_cuisine = db.Column(db.String(40), nullable=True)
    last_login = db.Column(db.DateTime, nullable=True)
    membership = db.Column(db.DateTime, nullable=True)

    #Defining relationship with comments and ratings table
    comments = db.relationship('Comment', backref='user')
    ratings = db.relationship('Rating', backref='user')


class Comment(db.Model):
    """User comments of restaurants."""

    __tablename__ = 'comments'

    comment_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    restaurant_id = db.Column(db.Integer, db.ForeignKey('restaurants.restaurant_id'))
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'))
    comment = db.Column(db.Text, nullable=False)

    comments = db.relationship('Restaurant', backref='restaurant')


class Rating(db.Model):
    """User ratings of restaurants."""

    __tablename__ = 'ratings'

    rating_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'))
    restaurant_id = db.Column(db.Integer, db.ForeignKey('restaurants.restaurant_id'))
    cleanliness = db.Column(db.Integer, nullable=True)
    quality = db.Column(db.Integer, nullable=True)
    atmosphere = db.Column(db.Integer, nullable=True)
    consistency = db.Column(db.Integer, nullable=True)


class Bookmark(db.Model):
    """List of user favorites."""

    __tablename__ = 'favorites'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'))
    restaurant_id = db.Column(db.Integer, db.ForeignKey('restaurants.restaurant_id'))


###################################################
#Helper functions

def connect_to_db(app):
    """Connect the database to our Flask app."""

    # Configure to use our PostgreSQL database
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///pocketasia'
    app.config['SQLALCHEMY_ECHO'] = True
    db.app = app
    db.init_app(app)


if __name__ == "__main__":
    # As a convenience, if we run this module interactively, it will leave
    # you in a state of being able to work with the database directly.

    from server import app
    connect_to_db(app)
    print "Connected to DB."
