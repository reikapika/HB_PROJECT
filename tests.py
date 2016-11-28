
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

    def test_get_user_by_user_id(self):
        """Test functionality of this helper function."""

        self.assertIsNotNone(get_user_by_user_id(2))

    def test_get_user_by_username(self):
        """Test functionality of this helper function."""

        self.assertIsNotNone(get_user_by_username("jhacks"))

    def test_homepage(self):

        result = self.client.get("/")

        self.assertIn('Welcome to', result.data)

    def test_login(self):

        result = self.client.get("/login")

        self.assertIn('Not a user yet?', result.data)


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

    def test_search_form(self):

        result = self.client.post('/search', data={'search-form': 'ac'}, follow_redirects=True)

        self.assertIn("Let's look it up!", result.data)

    def test_rating_page(self):

        restaurant_id = 1
        result = self.client.get('/ratings/%s' % restaurant_id, follow_redirects=True)

        self.assertIn("<strong>How do you think about this restaurant?</strong>", result.data)

    def test_comment_page(self):

        restaurant_id = 1
        result = self.client.get('/comments/%s' % restaurant_id, follow_redirects=True)

        self.assertIn("<strong>What do you think about this restaurant?</strong>", result.data)

    def test_restaurant_list(self):

        cuisine = 'Korean'
        result = self.client.get('/restaurant_list/%s' % cuisine, follow_redirects=True)

        self.assertIn("<strong>List of", result.data)


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

            self.assertIn("Last Login:", result.data)

    def test_add_favorite(self):

        if session:
            new_favorite = Bookmark(user_id=sess['user_id'],
                                    restaurant_id=1)
            db.session.add(new_favorite)
            db.session.commit()
            result = self.client.get('search_restaurant/1')

            self.assertEqual("successfully added to My Favorites", result.data)

    def test_remove_favorite(self):

        if session:
            query = Bookmark.query.filter_by(user_id=sess['user_id'], restaurant_id=1).first()
            db.session.delete(query)
            db.session.commit()

            self.assertIsNone(query)

    def test_yelp_call(self):

        if session:
            restaurant_id = 1
            result = self.client.get('/search_restaurant/%s' % restaurant_id, follow_redirects=True)

            self.assertIn("<b>Restaurant Information</b>", result.data)

    def test_lookup_cuisine(self):

        if session:
            result = self.client.get('/lookup_cuisine')

            self.assertIn("<strong>Restaurants Marked as Favorites</strong>", result.data)

    def test_add_restaurant(self):

        if session:
            self.client.post('/add_restaurant.json',
                             data={'name': 'Ichido'},
                             follow_redirects=True)

            query = Restaurant.query.filter_by(name='Ichido').first()

            self.assertIsNotNone(query)

    def test_check_restaurant(self):

        if session:
            result = self.client.post('/check_restaurant.json',
                                      data={'name': 'Yume Sushi'},
                                      follow_redirects=True)
            self.assertIs(result, object)

    def test_like_rest(self):

        if session:
            result = self.client.post('/like_rest.json',
                                      data={'restaurant_id': 1},
                                      follow_redirects=True)
            query = Popularity.query.filter_by(restaurant_id=1).first()
            if query:
                self.assertIn("unliked", result.data)
            else:
                self.assertIn("ok", result.data)


class FlaskTestsSessionLoggedOut(TestCase):
    """Flask tests with user logged in to session."""

    def setUp(self):
        """Stuff to do before every test."""

        app.config['TESTING'] = True
        self.client = app.test_client()

    def test_profile_page(self):
        """Test that user can't see profile page when logged out."""

        result = self.client.get("/profile/2", follow_redirects=True)

        self.assertNotIn("<strong>Account Details</strong>", result.data)
        self.assertIn("<strong>Please Log In</strong>", result.data)


if __name__ == "__main__":
    import unittest
    unittest.main()
