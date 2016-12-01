#San Franasia

**Project Description**

*San Franasia*  is a web app for local foodies with specific interests in Asian Cuisine. Registered users have full access to the app, and with queried results through the search feature, they can not only browse all the restaurants with the most up-to-date business info, but also can view, add, and edit restaurant comments and ratings from their enthusiastic fellows. Moreover, they can unveil more tasty places and share with others simply by adding new restaurant to the pool.  Users can also check out accurate distance and direction routes between their current positions and the restaurants. This app serves as a platform where lovers of exotic flavors can gather and share excitement.
#####Features in planning:
- social networking for users to create and sign up for tasting meetups
- machine learning: study users' favorite list and make a recommendation that fits their interest

###Tech Stack

Python
Flask
Jinja
SQLAlchemy
PostgreSQL
jQuery
AJAX

###Homepage
<img align="center" src="/static/screenshot/home.gif" width="500">

-Randomly selected restaurants and comments will display in a bootstrap carousel on every page load

###Search Feature can look up both restaurants and users
<img align="center" src="/static/screenshot/search.png" width="500">

-Look up users and check out their profile page (only for logged in users)
-Hyperlinks for all restaurants and direct to the restaurant info page


###Restaurant Info
<img align="center" src="/static/screenshot/restaurant_info.png" width="500">
<img align="center" src="/static/screenshot/map.png" width="500">

-On every page load, the server will make two API calls: first one to Yelp for most up to date business information, and then to Google for a brief direction from the user location (obtained by HTML 5 Geolocation) to the restaurant.
-All comments of the restaurant are results of a query in the database using the table relationship

###User Profile
<img align="center" src="/static/screenshot/profile.png" width="500">

-Keep track of last log in time and user favorites
-Detail history of each rating the user has given
-Users can delete the comments they have made 

### Set up San Franasia:

Clone this repository:

```$ git clone https://github.com/shioramen/HB_PROJECT.git```

Create a virtual environment and activate it:

```
$ virtualenv env
$ source env/bin/activate
```

Install the dependencies:

```$ pip install -r requirements.txt```

-Get an API key from Yelp.

-Run PostgreSQL.

-Create database with the name of your choice.

```$ createdb [your db name]```

Load the database with sanfranasia.sql:

```$ psql [your db name] < sanfranasia.sql```

Finally, to run the app, start the server:

```$ python server.py```

Go to `localhost:5000` in your browser to start exploring!

### Testing Coverage

-UnitTests and IntegrationTests have been implemented.

-Currently the coverage is 58%.

<img align="center" src="/static/screenshot/coverage.png" width="500">

To run tests, run the following command line:

```$ coverage run --omit=env/* tests.py```

To get a coverage report, run the following:

```$ coverage report -m```

For an HTML version of the report, run the running:

```
$ coverage html
$ open htmlcov/index.html
```



