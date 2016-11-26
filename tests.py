
from unittest import TestCase
from model import connect_to_db, db, User, Restaurant, Popularity, load_fake_data
from server import *
import pdb


class FlaskTestBasic(TestCase):
    def setUp(self):
        """Stuff to do before every test."""

        self.client = app.test_client()
        app.config['TESTING'] = True
        connect_to_db(app, "postgresql:///testdb")
        db.create_all()
        load_fake_data()

    def tearDown(self):
        """Do at end of every test."""

        db.session.close()
        db.drop_all()

    def test_num_likes_calculator(self):
        """Test if num_like_calculator function returns the correct numbers of objects."""
        restaurant = Restaurant.query.filter_by(restaurant_id=1).first()
        for i in range(5):
            popularity = Popularity(user_id=(1+i),
                                    restaurant_id=restaurant.restaurant_id)

            db.session.add(popularity)
        db.session.commit()

        self.assertEqual(restaurant.num_like_calculator(), 5)

    def test_get_sample_restaurant_by_cuisine(self):
        """Test functionality of this helper function."""
        query = Restaurant.query.filter_by(cuisine_id=1).first()

        self.assertEqual(get_sample_restaurant_by_cuisine(1).cuisine_id, query.cuisine_id)

    def test_get_comments_by_restaurant(self):
        """Test functionality of this helper function."""
        query = Restaurant.query.filter_by(restaurant_id=1).first()
        self.assertEqual(get_comments_by_restaurant(1).comments.restaurant_id, query.restaurant_id)

    def test_get_user_by_user_id(self):
        """Test functionality of this helper function."""

        self.assertIsNotNone(get_user_by_user_id(2))

    def test_get_user_by_username(self):
        """Test functionality of this helper function."""

        self.assertIsNotNone(get_user_by_username("jhacks"))


class IntegrationTest(TestCase):
    def setUp(self):

        self.client = app.test_client()
        app.config['TESTING'] = True
        connect_to_db(app, "postgresql:///testdb")
        db.create_all()
        load_fake_data()

    def tearDown(self):
        """Do at end of every test."""

        db.session.close()
        db.drop_all()

    def test_homepage(self):

        result = self.client.get("/")
        self.assertIn('<option value="Japanese">Japanese</option>', result.data)

    def test_register(self):

        new_user = User(username="jchoo",
                        password=123,
                        fname="Jimmy",
                        lname="Choo",
                        fav_cuisine="Japanese",
                        membership=datetime.utcnow(),
                        last_login=datetime.utcnow()
                        )
        db.session.add(new_user)
        db.session.commit()

        result = self.client.get("/register", new_user, follow_redirects=True)
        self.assertIsNotNone("Welcome, Jimmy!", result.data)


class FlaskTestsSessionLoggedIn(TestCase):
    """Flask tests with user logged in to session."""

    def setUp(self):
        """Stuff to do before every test."""

        app.config['TESTING'] = True
        app.config['SECRET_KEY'] = 'key'
        self.client = app.test_client()

        with self.client as c:
            with c.session_transaction() as sess:
                sess['user_id'] = 1

    def test_profile_page(self):
        """Test profile page."""

        if session:
            result = self.client.get("/profile/%s" % sess['user_id'])
            self.assertIn("<h1>User Profile</h1>", result.data)


class FlaskTestsSessionLoggedOut(TestCase):
    """Flask tests with user logged in to session."""

    def setUp(self):
        """Stuff to do before every test."""

        app.config['TESTING'] = True
        self.client = app.test_client()

    def test_profile_page(self):
        """Test that user can't see profile page when logged out."""

        result = self.client.get("/profile/<user_id>", follow_redirects=True)
        self.assertNotIn("<h2>Account Details</h2>", result.data)
        self.assertIn("<h1>Please log in.</h1>", result.data)


if __name__ == "__main__":
    import unittest
    unittest.main()
