# import unittest
from unittest import TestCase, main as run_tests
from server import app
from model import connect_to_db, db, User, Restaurant, Popularity


# import pdb
# pdb.set_trace()


class RestaurantTest(TestCase):
    def setUp(self):
        """Stuff to do before every test."""

        self.client = app.test_client()
        app.config['TESTING'] = True
        db_url = "postgresql:///testdb"
        app.config['SQLALCHEMY_DATABASE_URI'] = db_url
        connect_to_db(app)
        db.create_all()

    def tearDown(self):
        """Do at end of every test."""

        db.session.close()
        db.drop_all()

    def test_num_likes_calculator(self):

        restaurant = Restaurant(name="A Ramen",
                                latitude=37,
                                longitude=122,
                                )
        db.session.add(restaurant)
        db.session.commit()

        for i in range(5):
            user = User(username='user-' + str(i),
                        password='123',
                        fav_cuisine='Thai',
                        )

            db.session.add(user)
            db.session.commit()

            popularity = Popularity(user_id=user.user_id,
                                    restaurant_id=restaurant.restaurant_id)

            db.session.add(popularity)
            db.session.commit()

        self.assertEqual(restaurant.num_like_calculator(), 5) # == 5

if __name__ == "__main__":
    run_tests()
