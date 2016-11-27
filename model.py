from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()

#Model definition


class Cuisine(db.Model):
    """Cuisine types of Pocket Asia"""

    __tablename__ = 'cuisine'

    cuisine_id = db.Column(db.Integer,
                           primary_key=True,
                           autoincrement=True)
    type = db.Column(db.String(40), nullable=False)

    #Defining relationship with restaurants table
    restaurants = db.relationship('Restaurant', backref='cuisine')


class Restaurant(db.Model):
    """Restaurants"""

    __tablename__ = 'restaurants'

    restaurant_id = db.Column(db.Integer,
                              primary_key=True,
                              autoincrement=True)
    name = db.Column(db.String(50), nullable=False)
    yelp_id = db.Column(db.String(100), nullable=True)
    yelp_rating = db.Column(db.Integer, nullable=True)
    image = db.Column(db.String(200), nullable=True)
    latitude = db.Column(db.Float, nullable=False)
    longitude = db.Column(db.Float, nullable=False)
    cuisine_id = db.Column(db.Integer, db.ForeignKey('cuisine.cuisine_id'))

    #Defining relationship with likes and ratings table

    ratings = db.relationship('Rating', backref='restaurant')
    likes = db.relationship('Popularity', backref='restaurant')

    def num_like_calculator(self):
        """returns number of likes for a restaurant"""
        return len(self.likes)


class User(db.Model):
    """Users of Pocket Asia."""

    __tablename__ = 'users'

    user_id = db.Column(db.Integer,
                        primary_key=True,
                        autoincrement=True)
    username = db.Column(db.String(50), nullable=False, unique=True)
    password = db.Column(db.String(65), nullable=False)
    fname = db.Column(db.String(50), nullable=True)
    lname = db.Column(db.String(50), nullable=True)
    fav_cuisine = db.Column(db.String(40), nullable=False)
    last_login = db.Column(db.DateTime,
                           nullable=False,
                           default=datetime.utcnow,
                           onupdate=datetime.utcnow)
    membership = db.Column(db.DateTime,
                           nullable=False,
                           default=datetime.utcnow)

    #Defining relationship with comments and ratings table
    comments = db.relationship('Comment', backref='user')
    ratings = db.relationship('Rating', backref='user')


class Comment(db.Model):
    """User comments of restaurants."""

    __tablename__ = 'comments'

    comment_id = db.Column(db.Integer,
                           primary_key=True,
                           autoincrement=True)
    restaurant_id = db.Column(db.Integer,
                              db.ForeignKey('restaurants.restaurant_id'))
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'))
    comment = db.Column(db.Text, nullable=False)

    #Defining relationship with restaurant table
    comments = db.relationship('Restaurant', backref='restaurant')
    likes = db.relationship('Popularity', backref='comment')

    def num_like_calculator(self):
        """returns number of likes for a comment"""
        return len(self.likes)


class Rating(db.Model):
    """User ratings of restaurants."""

    __tablename__ = 'ratings'

    rating_id = db.Column(db.Integer,
                          primary_key=True,
                          autoincrement=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'))
    restaurant_id = db.Column(db.Integer,
                              db.ForeignKey('restaurants.restaurant_id'))
    cleanliness = db.Column(db.Integer, nullable=True)
    quality = db.Column(db.Integer, nullable=True)
    atmosphere = db.Column(db.Integer, nullable=True)
    consistency = db.Column(db.Integer, nullable=True)


class Bookmark(db.Model):
    """List of user favorites."""

    __tablename__ = 'favorites'

    id = db.Column(db.Integer,
                   primary_key=True,
                   autoincrement=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'))
    restaurant_id = db.Column(db.Integer,
                              db.ForeignKey('restaurants.restaurant_id'))


class Popularity(db.Model):
    """Keep track of user likes."""

    __tablename__ = "popularity"

    id = db.Column(db.Integer,
                   primary_key=True,
                   autoincrement=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'))
    comment_id = db.Column(db.Integer, db.ForeignKey('comments.comment_id'))
    restaurant_id = db.Column(db.Integer,
                              db.ForeignKey('restaurants.restaurant_id'))

    #Defining table relationship with users and restaurants
    users = db.relationship("User", backref="popularity")
    comments = db.relationship("Comment", backref="popularity")
    restaurants = db.relationship("Restaurant", backref="popularity")


###################################################
#Helper functions
def load_fake_data():
    #load cuisine
    CUISINE = ['Japanese', 'Chinese', 'Korean', 'Indian', 'Vietnamese', 'Thai', 'Middle Eastern']

    for type in CUISINE:
        cuisine = Cuisine(type=type)

        db.session.add(cuisine)
    db.session.commit()

    for i in range(7):
        name = "Mr. Holmes #" + str(i)
        yelp_id = i + 3
        latitude = 20 + i
        longitude = -122 + i
        yelp_rating = 2 + i
        cuisine_id = i + 1
        restaurant_id = 1 + i
        restaurant = Restaurant(restaurant_id=restaurant_id,
                                name=name,
                                yelp_id=yelp_id,
                                yelp_rating=yelp_rating,
                                latitude=latitude,
                                longitude=longitude,
                                cuisine_id=cuisine_id,
                                )

        db.session.add(restaurant)
    db.session.commit()

    usernames = ["jhacks", "cbob", "ksmith", "awalker",
                 "jsmith", "acooper", "tshawn", "bdraco", "sgregor", "lkim"]
    passwords = 123
    fnames = ["Jane", "Chris", "Kay", "Allen", "John",
              "Alex", "Thomas", "Bob", "Sydney", "Lyn"]
    lnames = ["Hacks", "Bob", "Smith", "Walker", "Smith",
              "Cooper", "Shawn", "Draco", "Gregor", "Kim"]
    cuisine = ["Japanese", "Chinese", "Korean", "Indian", "Vietnamese",
               "Middle Eastern", "Japanese", "Indian", "Korean", "Chinese"]
    membership = datetime.utcnow()
    last_login = datetime.utcnow()
    for i in range(10):
        user = User(username=usernames[i],
                    password=passwords,
                    fname=fnames[i],
                    lname=lnames[i],
                    fav_cuisine=cuisine[i],
                    membership=membership,
                    last_login=last_login
                    )

        db.session.add(user)
    db.session.commit()

    comment1 = Comment(user_id=1,
                       restaurant_id=1,
                       comment="this restaurant is great!!!!")
    db.session.add(comment1)
    db.session.commit()


def connect_to_db(app, db_uri="postgresql:///pocketasia"):
    app.config['SQLALCHEMY_DATABASE_URI'] = db_uri
    db.app = app
    db.init_app(app)


if __name__ == "__main__":
    # As a convenience, if we run this module interactively, it will leave
    # you in a state of being able to work with the database directly.

    from server import app
    connect_to_db(app)
    print "Connected to DB."
