--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE comments (
    comment_id integer NOT NULL,
    restaurant_id integer,
    user_id integer,
    comment text NOT NULL
);


ALTER TABLE comments OWNER TO vagrant;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE comments_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comments_comment_id_seq OWNER TO vagrant;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE comments_comment_id_seq OWNED BY comments.comment_id;


--
-- Name: cuisine; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE cuisine (
    cuisine_id integer NOT NULL,
    type character varying(40) NOT NULL
);


ALTER TABLE cuisine OWNER TO vagrant;

--
-- Name: cuisine_cuisine_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE cuisine_cuisine_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cuisine_cuisine_id_seq OWNER TO vagrant;

--
-- Name: cuisine_cuisine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE cuisine_cuisine_id_seq OWNED BY cuisine.cuisine_id;


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE favorites (
    id integer NOT NULL,
    user_id integer,
    restaurant_id integer
);


ALTER TABLE favorites OWNER TO vagrant;

--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE favorites_id_seq OWNER TO vagrant;

--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE favorites_id_seq OWNED BY favorites.id;


--
-- Name: popularity; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE popularity (
    id integer NOT NULL,
    user_id integer,
    comment_id integer,
    restaurant_id integer
);


ALTER TABLE popularity OWNER TO vagrant;

--
-- Name: popularity_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE popularity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE popularity_id_seq OWNER TO vagrant;

--
-- Name: popularity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE popularity_id_seq OWNED BY popularity.id;


--
-- Name: ratings; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE ratings (
    rating_id integer NOT NULL,
    user_id integer,
    restaurant_id integer,
    cleanliness integer,
    quality integer,
    atmosphere integer,
    consistency integer
);


ALTER TABLE ratings OWNER TO vagrant;

--
-- Name: ratings_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE ratings_rating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ratings_rating_id_seq OWNER TO vagrant;

--
-- Name: ratings_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE ratings_rating_id_seq OWNED BY ratings.rating_id;


--
-- Name: restaurants; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE restaurants (
    restaurant_id integer NOT NULL,
    name character varying(50) NOT NULL,
    yelp_id character varying(100),
    yelp_rating integer,
    image character varying(200),
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    cuisine_id integer
);


ALTER TABLE restaurants OWNER TO vagrant;

--
-- Name: restaurants_restaurant_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE restaurants_restaurant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE restaurants_restaurant_id_seq OWNER TO vagrant;

--
-- Name: restaurants_restaurant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE restaurants_restaurant_id_seq OWNED BY restaurants.restaurant_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(65) NOT NULL,
    fname character varying(50),
    lname character varying(50),
    fav_cuisine character varying(40) NOT NULL,
    last_login timestamp without time zone NOT NULL,
    membership timestamp without time zone NOT NULL
);


ALTER TABLE users OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: comment_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY comments ALTER COLUMN comment_id SET DEFAULT nextval('comments_comment_id_seq'::regclass);


--
-- Name: cuisine_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY cuisine ALTER COLUMN cuisine_id SET DEFAULT nextval('cuisine_cuisine_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY favorites ALTER COLUMN id SET DEFAULT nextval('favorites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY popularity ALTER COLUMN id SET DEFAULT nextval('popularity_id_seq'::regclass);


--
-- Name: rating_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY ratings ALTER COLUMN rating_id SET DEFAULT nextval('ratings_rating_id_seq'::regclass);


--
-- Name: restaurant_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY restaurants ALTER COLUMN restaurant_id SET DEFAULT nextval('restaurants_restaurant_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY comments (comment_id, restaurant_id, user_id, comment) FROM stdin;
1	7	3	The food was absolutely wonderful, from preparation to presentation, very pleasing.
3	5	2	The poolside common areas are great with chairs and umbrellas for free. Also the servers are ever present to provide whatever you like from their cafe menu. My wife is hard to cook for since she has to special order for low salt. The chef nailed it perfectly. That was memorable.
4	6	2	Just finished our annual stay at the King and Prince; as always we had an amazing experience, it was an almost perfect stay as always. I would like to say that everyone was always accommodating and helpful when needed. Kudos to all the wait staff by the pool and in the tavern...Kelly was the best bartender ever!. . . we loved everything about the King and Prince and will be returning same time next year. This is the sixth year we have spent the same week at the King and Prince and look forward to it all year long.
5	1	2	Just finished our annual stay at the King and Prince; as always we had an amazing experience, it was an almost perfect stay as always. I would like to say that everyone was always accommodating and helpful when needed. Kudos to all the wait staff by the pool and in the tavern...Kelly was the best bartender ever!. . . we loved everything about the King and Prince and will be returning same time next year. This is the sixth year we have spent the same week at the King and Prince and look forward to it all year long.
6	46	2	Read more comments on Accommodations, Amenities, and Activities \r\n\r\nRestaurant \r\nJoshua C., from TripAdvisor, says:\r\n\r\nWe had lunch here a few times while on the island visiting family and friends. The servers here are just wonderful and have great memories it seems. We sat on the ocean front patio and enjoyed the view with our delicious wine and lunch. Must try!\r\nVictoria C., from Guest Comment, says:\r\n\r\nHello. Please give our thanks to the Manager(s) and others for the wonderful room and bottle of sparkling wine for our Anniversary stay. We had an amazing time. The room was so comfortable, the food at Echo absolutely spectacular (we ate two meals there). Our waitress was just wonderful. Looking forward to staying with you in the future. What a great place! \r\nAnonymous, from TripAdvisor, says:\r\n\r\nSpent 3 nights at this resort earlier this month and it was a great stay! We paid for an upgrade to the oceanfront cabana, which was worth the price. The beach views, calm ocean and ability to watch the sunset on our patio were highlights of the trip! The hotel restaurant was exceptional, not only because every meal we enjoyed had a variety of options and was flavorful but also because the prices were so reasonable for an oceanfront resort! The entire island and resort were a lot more laid back and calm than other touristy coastal front towns in the southeast, but that may in part due to it being early March. I'd imagine there's a bit more traffic during high seasons, but either way, we'll definitely be back! Highly recommended!\r\nPeita, from Guest Survey, says:\r\n\r\nRachel at the Pool (drinks server) was so gorgeous. We chatted with her all weekend and she played with the kids. She's an asset to the hotel esp for people with families. I saw other attendants playing with the kids too which is so welcoming. Rachel was gorgeous. Give her a raise! \r\nMindy, from TripAdvisor, says:\r\n\r\nI had lunch with some of my colleagues at Echo on Day 1. I had the wedge salad - it was delicious. On Night 2, I enjoyed a drink at the bar. I had a Margarita. The service was excellent. \r\nPhil, from TripAdvisor says:\r\n\r\nDinner in the King and Prince's new restaurant-ECHO (open only 12 days) interesting menu, wonderful meal that was perfectly served by our waiter, Peter, who also filled us in on the local community. Room service breakfast was exactly on time, hot (not warm) food and oh so good. All in all, a perfect stay!!\r\nJudy S, in letter, says:\r\n\r\nThe food was absolutely wonderful, from preparation to presentation, very pleasing. We especially enjoyed the special bar drinks, the cucumber/cilantro infused vodka martini and the K&P Aquarium was great (even took photos so we could try to replicate at home).\r\nAnonymous, from TripAdvisor, says:\r\n\r\nAlthough we didn't go into the onsite restaurant, we ordered some food at the bar a few times and it was delicious. The bar area and lobby were nice and open, good place to relax and meet friends.\r\nLeigh C., from Guest Survey, says:\r\n\r\nMy only (dining) experience was ordering a pizza at 9:15pm. Tanner answered my telephone call to inquire about the time of service and the pizza options. He took a lot of time discussing details with me and even went over the menu - assuring me that I would have my pizza by the time the kitchen closed at 10pm. At 9:45 the pizza was delivered PIPING HOT as if I were sitting in a restaurant. It was delicious and exactly what I ordered.\r\nDave H., from TripAdvisor, says:\r\n\r\nI was expecting the food here to follow in the old Southern tradition but was pleased to find the menus trending in a contemporary direction with emphasis on lean, fresh and organic fare -- while still keeping with Low Country/Southern convention. My favorite dish at the Ocean Terrace Restaurant, in fact, was shrimp and grits topped with a tasty tasso sauce and loaded with locally netted Georgia white shrimp,which are positively unmatched for flavor.\r\nThe chef and his staff are staunch advocates of the farm-to-table concept, sourcing produce, meats, poultry and dairy products almost exclusively from Georgia organic farms.\r\nFran K., from Guest Comment, says:\r\n\r\nLovely lunch today. Ordered the crab cake sandwich and was pleased by the quality of the crab cake, as well as the nicely toasted roll, thick slices of ripe avocado, and crisp hot bacon which accompanied it. The side of fresh fruit was also generous and perfectly ripe. A very good experience! Add this to the best dining view on the island on a gorgeous Fall day, and it adds up to perfection!\r\nAnonymous, from TripAdvisor, says:\r\n\r\nThe food was fresh, properly prepared and a great value for the price. We highly recommend it. The breakfast buffet on Sunday was equally as good. \r\nJessica W., from Guest Letter, says:\r\n\r\nJust finished our annual stay at the King and Prince; as always we had an amazing experience, it was an almost perfect stay as always. I would like to say that everyone was always accommodating and helpful when needed. Kudos to all the wait staff by the pool and in the tavern...Kelly was the best bartender ever!. . . we loved everything about the King and Prince and will be returning same time next year. This is the sixth year we have spent the same week at the King and Prince and look forward to it all year long.\r\nGuest Letter:\r\n\r\nThank you so much for taking such wonderful care of our family during our visit to the King and Prince. You and your staff were so very accommodating and informed about our special dietary needs. The food at the King’s Tavern was always delicious!\r\nMy son had a wonderful time and liked that he could order special food and the chef would make it so he could eat it. If you wouldn’t mind telling me how you prepared the fish, I would like to try making some for him at home, since he enjoyed it so much. He even asked if we could stay until his birthday in July. He said that he wanted to have his birthday at the beach too! What a thoughtful gesture to have the cake for my niece on her birthday! It was delicious, and my son and my mom enjoyed their desserts as well. I know my niece will remember her 10th birthday for years to come!\r\nThank you also for having the special gluten free items for my mother. I tried the blueberry muffin and it was delicious! It was so nice to know we didn’t have to worry as much about our food while on vacation, and that we were able to order it and not have to bring a lot of food with us.\r\nOnce again THANK YOU SO MUCH for everything! We had a great vacation, and you and your staff helped to make it that way! We will be back next year! I’ll be sure to let you know in advance before we come again.\r\nThanks again for all your hard work and consideration,\r\n\r\nMelanie P.\r\n\r\nAnonymous, from TripAdvisor says:\r\n\r\nReception and all service staff were very helpful and cordial. Our beachfront room on the third floor had a balcony and a great view of the pool area, the ocean, and sunrise- magnificent. Food in the tavern for dinner and breakfast was good. Especially liked the lowcountry shrimp and grits. They surprised my husband with a slice of chocolate cake with "Happy Birthday" written on the plate when we casually mentioned that it was his birthday!\r\n\r\nAnonymous, from TripAdvisor says:\r\n\r\nThe poolside common areas are great with chairs and umbrellas for free. Also the servers are ever present to provide whatever you like from their cafe menu. My wife is hard to cook for since she has to special order for low salt. The chef nailed it perfectly. That was memorable.\r\n\r\nAnonymous, from TripAdvisor says:\r\n\r\nThe breakfast brunch was great. We went at 10:45 and everything was still hot and there was plenty of everything. Our server was very friendly and took good care of us. We enjoyed sitting at the pool and enjoying cocktails. We also loved walking on the beach.\r\n\r\nGlen B from TripAdvisor says:\r\n\r\nFrom check in to check out, the staff is fantastic. At check in they gave us great information on local restaurants and things happening at the resort for the week. The in house restaurant staff is very accommodating and nice. A breath of fresh air to most places we have been. The outside pool service is great for food and drinks. We used this almost everyday for lunch. The beach at this resort is fantastic as well. At low tide you can see all sorts of things from starfish, crabs, shells, sand dollars, etc. We even found three horseshoe crabs in the tide pools at low tide. We will definitely vacation here again.\r\n\r\nAnonymous, from TripAdvisor says:\r\n\r\nAll the good reviews that I have read about this property are true. The friendliness of the staff seems genuine. I have never seen such good customer service as I experienced poolside.\r\n\r\nDeanna C, from Guest Comment Form says:\r\n\r\nHad a terrific dinner (Thanksgiving Buffet) today at the King and Prince with good food, wonderful service.\r\n\r\nJoyce P, from Post Stay Questionnaire says:\r\n\r\nThe food was amazing, and we enjoyed perfect wait service from James.\r\n\r\nTom M, from TripAdvisor\r\n\r\nThe hotel's room service food was really great. My adult daughter said the fries were the best ever. The breakfast was top notch, and dinner was really nice as well. \r\nBill I, from Post Stay Questionnaire says:\r\n\r\nWait staff were extremely friendly and helpful. Delicious meals! \r\nJoseph P, from Post Stay Questionnaire says:\r\n\r\nEverything brought to us through room service was impeccable. We were celebrating a birthday, and several unique requests that were all satisfied perfectly.\r\n\r\nTeresa D, from Post Stay Questionnaire says:\r\n\r\nService was very good and servers were kind, friendly and even offered to-go coffees in the morning for us to take back to our room.\r\n\r\nAnonymous, from Guest Insight says:\r\nIt was beautiful-peaceful and relaxing. Staff was outstanding. The restaurant was exceptional along with the hosts and servers.
7	47	2	It was beautiful-peaceful and relaxing. Staff was outstanding. The restaurant was exceptional along with the hosts and servers.
8	6	2	It was beautiful-peaceful and relaxing. Staff was outstanding. The restaurant was exceptional along with the hosts and servers.
10	91	3	Service was very good and servers were kind, friendly and even offered to-go coffees in the morning for us to take back to our room.
11	7	3	It was beautiful-peaceful and relaxing. Staff was outstanding. The restaurant was exceptional along with the hosts and servers.
382	124	9	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
13	1	2	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
14	1	2	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
15	1	2	"the food was brilliant."
16	2	3	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
17	2	3	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
18	2	3	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
19	3	9	"Great place for lunch or dinner."
20	3	9	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
21	3	9	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
22	4	2	"the food was brilliant."
23	4	2	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
24	4	2	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
25	5	6	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
26	5	6	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
27	5	6	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
28	6	8	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
29	6	8	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
30	6	8	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
31	7	6	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
32	7	6	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
33	7	6	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
34	8	4	"This charming little restaurant serves terrific food in a cozy environment."
35	8	4	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
36	8	4	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
37	9	8	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
38	9	8	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
39	9	8	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
153	47	4	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
40	10	5	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
41	10	5	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
42	10	5	"Cozy dining room, friendly wait staff, and terrific prices."
43	11	10	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
44	11	10	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
45	11	10	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
46	12	10	"Great place for lunch or dinner."
47	12	10	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
48	12	10	"the food was brilliant."
49	13	6	"the ambiance and decor excellent."
50	13	6	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
51	13	6	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
52	14	4	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
53	14	4	"They had us at the complimentary bowl of lentil soup--the chef's special."
54	14	4	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
55	15	4	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
56	15	4	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
57	15	4	"the food was brilliant."
58	16	5	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
59	16	5	"This charming little restaurant serves terrific food in a cozy environment."
60	16	5	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
64	18	3	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
65	18	3	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
66	18	3	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
67	19	8	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
68	19	8	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
69	19	8	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
70	20	2	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
71	20	2	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
72	20	2	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
73	21	9	"the ambiance and decor excellent."
74	21	9	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
75	21	9	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
76	22	5	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
77	22	5	"They had us at the complimentary bowl of lentil soup--the chef's special."
78	22	5	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
81	23	7	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
82	24	10	"the ambiance and decor excellent."
83	24	10	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
84	24	10	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
85	25	6	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
86	25	6	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
87	25	6	"Great place for lunch or dinner."
91	27	6	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
92	27	6	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
93	27	6	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
94	28	7	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
95	28	7	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
96	28	7	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
97	29	5	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
98	29	5	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
99	29	5	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
100	30	2	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
101	30	2	"They had us at the complimentary bowl of lentil soup--the chef's special."
102	30	2	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
103	31	4	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
104	31	4	"the ambiance and decor excellent."
105	31	4	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
115	35	2	"This charming little restaurant serves terrific food in a cozy environment."
116	35	2	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
117	35	2	"the food was brilliant."
661	217	2	"Great place for lunch or dinner."
118	36	2	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
119	36	2	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
120	36	2	"They had us at the complimentary bowl of lentil soup--the chef's special."
121	37	8	"They had us at the complimentary bowl of lentil soup--the chef's special."
122	37	8	"the ambiance and decor excellent."
123	37	8	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
124	38	7	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
125	38	7	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
126	38	7	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
127	39	4	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
128	39	4	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
129	39	4	"Cozy dining room, friendly wait staff, and terrific prices."
130	40	3	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
131	40	3	"the food was brilliant."
132	40	3	"Great place for lunch or dinner."
133	41	6	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
134	41	6	"the food was brilliant."
135	41	6	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
136	42	4	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
137	42	4	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
138	42	4	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
139	43	3	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
140	43	3	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
141	43	3	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
142	44	5	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
143	44	5	"Cozy dining room, friendly wait staff, and terrific prices."
144	44	5	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
145	45	8	"This charming little restaurant serves terrific food in a cozy environment."
146	45	8	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
147	45	8	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
151	47	4	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
152	47	4	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
154	48	3	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
155	48	3	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
156	48	3	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
157	49	2	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
158	49	2	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
159	49	2	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
160	50	3	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
161	50	3	"the ambiance and decor excellent."
162	50	3	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
163	51	3	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
164	51	3	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
165	51	3	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
166	52	5	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
167	52	5	"They had us at the complimentary bowl of lentil soup--the chef's special."
168	52	5	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
172	54	3	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
173	54	3	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
174	54	3	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
175	55	4	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
176	55	4	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
177	55	4	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
178	56	8	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
179	56	8	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
180	56	8	"the food was brilliant."
181	57	10	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
182	57	10	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
183	57	10	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
184	58	10	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
185	58	10	"the ambiance and decor excellent."
186	58	10	"Great place for lunch or dinner."
187	59	2	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
188	59	2	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
189	59	2	"Cozy dining room, friendly wait staff, and terrific prices."
190	60	8	"the ambiance and decor excellent."
191	60	8	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
192	60	8	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
193	61	6	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
194	61	6	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
195	61	6	"They had us at the complimentary bowl of lentil soup--the chef's special."
196	62	9	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
197	62	9	"Great place for lunch or dinner."
198	62	9	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
199	63	2	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
200	63	2	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
201	63	2	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
202	64	4	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
203	64	4	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
204	64	4	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
205	65	3	"Great place for lunch or dinner."
206	65	3	"They had us at the complimentary bowl of lentil soup--the chef's special."
207	65	3	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
208	66	8	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
209	66	8	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
210	66	8	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
211	67	10	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
212	67	10	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
213	67	10	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
214	68	10	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
215	68	10	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
216	68	10	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
217	69	8	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
218	69	8	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
219	69	8	"Cozy dining room, friendly wait staff, and terrific prices."
220	70	3	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
221	70	3	"This charming little restaurant serves terrific food in a cozy environment."
222	70	3	"They had us at the complimentary bowl of lentil soup--the chef's special."
223	71	1	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
225	71	1	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
226	72	7	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
227	72	7	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
272	87	9	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
231	73	1	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
232	74	8	"the ambiance and decor excellent."
233	74	8	"Cozy dining room, friendly wait staff, and terrific prices."
234	74	8	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
235	75	8	"Great place for lunch or dinner."
236	75	8	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
237	75	8	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
238	76	8	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
239	76	8	"the food was brilliant."
240	76	8	"They had us at the complimentary bowl of lentil soup--the chef's special."
241	77	4	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
242	77	4	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
243	77	4	"This charming little restaurant serves terrific food in a cozy environment."
244	78	3	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
245	78	3	"the ambiance and decor excellent."
246	78	3	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
247	79	8	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
248	79	8	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
249	79	8	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
250	80	10	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
251	80	10	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
252	80	10	"the ambiance and decor excellent."
253	81	5	"This charming little restaurant serves terrific food in a cozy environment."
254	81	5	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
255	81	5	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
256	82	4	"Cozy dining room, friendly wait staff, and terrific prices."
257	82	4	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
258	82	4	"This charming little restaurant serves terrific food in a cozy environment."
259	83	5	"They had us at the complimentary bowl of lentil soup--the chef's special."
260	83	5	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
261	83	5	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
262	84	9	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
263	84	9	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
264	84	9	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
265	85	3	"Great place for lunch or dinner."
266	85	3	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
267	85	3	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
268	86	2	"the food was brilliant."
269	86	2	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
270	86	2	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
271	87	9	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
383	124	9	"This charming little restaurant serves terrific food in a cozy environment."
273	87	9	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
274	88	10	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
275	88	10	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
276	88	10	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
277	89	5	"the ambiance and decor excellent."
278	89	5	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
279	89	5	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
280	90	3	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
281	90	3	"They had us at the complimentary bowl of lentil soup--the chef's special."
282	90	3	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
283	91	9	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
284	91	9	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
285	91	9	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
286	92	8	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
287	92	8	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
288	92	8	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
289	93	7	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
290	93	7	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
291	93	7	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
292	94	1	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
293	94	1	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
295	95	6	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
296	95	6	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
297	95	6	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
298	96	9	"This charming little restaurant serves terrific food in a cozy environment."
299	96	9	"the ambiance and decor excellent."
300	96	9	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
301	97	8	"This charming little restaurant serves terrific food in a cozy environment."
302	97	8	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
303	97	8	"the ambiance and decor excellent."
304	98	1	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
305	98	1	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
306	98	1	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
307	99	5	"the ambiance and decor excellent."
308	99	5	"the food was brilliant."
309	99	5	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
620	203	10	"Cozy dining room, friendly wait staff, and terrific prices."
310	100	4	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
311	100	4	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
312	100	4	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
313	101	2	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
314	101	2	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
315	101	2	"the ambiance and decor excellent."
316	102	3	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
317	102	3	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
318	102	3	"This charming little restaurant serves terrific food in a cozy environment."
319	103	8	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
320	103	8	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
321	103	8	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
322	104	4	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
323	104	4	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
324	104	4	"the ambiance and decor excellent."
325	105	5	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
326	105	5	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
327	105	5	"Cozy dining room, friendly wait staff, and terrific prices."
328	106	9	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
329	106	9	"the food was brilliant."
330	106	9	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
331	107	7	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
332	107	7	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
333	107	7	"the food was brilliant."
334	108	2	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
335	108	2	"the food was brilliant."
336	108	2	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
337	109	6	"Great place for lunch or dinner."
338	109	6	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
339	109	6	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
340	110	4	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
341	110	4	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
342	110	4	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
343	111	10	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
344	111	10	"Cozy dining room, friendly wait staff, and terrific prices."
380	123	8	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
345	111	10	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
346	112	9	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
347	112	9	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
348	112	9	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
349	113	2	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
350	113	2	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
351	113	2	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
352	114	3	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
353	114	3	"Great place for lunch or dinner."
354	114	3	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
355	115	4	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
356	115	4	"Great place for lunch or dinner."
357	115	4	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
358	116	10	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
359	116	10	"the food was brilliant."
360	116	10	"They had us at the complimentary bowl of lentil soup--the chef's special."
361	117	6	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
362	117	6	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
363	117	6	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
364	118	5	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
365	118	5	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
366	118	5	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
367	119	6	"the food was brilliant."
368	119	6	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
369	119	6	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
370	120	6	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
371	120	6	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
372	120	6	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
373	121	3	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
374	121	3	"They had us at the complimentary bowl of lentil soup--the chef's special."
375	121	3	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
376	122	4	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
377	122	4	"This charming little restaurant serves terrific food in a cozy environment."
378	122	4	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
379	123	8	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
381	123	8	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
384	124	9	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
385	125	3	"the ambiance and decor excellent."
386	125	3	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
387	125	3	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
388	126	2	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
389	126	2	"the ambiance and decor excellent."
390	126	2	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
391	127	6	"This charming little restaurant serves terrific food in a cozy environment."
392	127	6	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
393	127	6	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
394	128	10	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
395	128	10	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
396	128	10	"Great place for lunch or dinner."
397	129	9	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
398	129	9	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
399	129	9	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
400	130	8	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
401	130	8	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
402	130	8	"the ambiance and decor excellent."
403	131	8	"This charming little restaurant serves terrific food in a cozy environment."
404	131	8	"They had us at the complimentary bowl of lentil soup--the chef's special."
405	131	8	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
406	132	10	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
407	132	10	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
408	132	10	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
409	133	4	"the food was brilliant."
410	133	4	"Great place for lunch or dinner."
411	133	4	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
412	134	6	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
413	134	6	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
414	134	6	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
415	135	10	"This charming little restaurant serves terrific food in a cozy environment."
416	135	10	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
417	135	10	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
418	136	10	"Great place for lunch or dinner."
419	136	10	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
420	136	10	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
421	137	7	"Cozy dining room, friendly wait staff, and terrific prices."
422	137	7	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
423	137	7	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
424	138	2	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
425	138	2	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
426	138	2	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
427	139	8	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
428	139	8	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
429	139	8	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
430	140	4	"Great place for lunch or dinner."
431	140	4	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
432	140	4	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
433	141	4	"This charming little restaurant serves terrific food in a cozy environment."
434	141	4	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
435	141	4	"the food was brilliant."
436	142	3	"This charming little restaurant serves terrific food in a cozy environment."
437	142	3	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
438	142	3	"Cozy dining room, friendly wait staff, and terrific prices."
439	143	10	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
440	143	10	"This charming little restaurant serves terrific food in a cozy environment."
441	143	10	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
442	144	4	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
443	144	4	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
444	144	4	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
445	145	5	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
446	145	5	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
447	145	5	"They had us at the complimentary bowl of lentil soup--the chef's special."
448	146	4	"Cozy dining room, friendly wait staff, and terrific prices."
449	146	4	"This charming little restaurant serves terrific food in a cozy environment."
450	146	4	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
451	147	6	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
452	147	6	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
453	147	6	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
454	148	9	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
455	148	9	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
456	148	9	"Cozy dining room, friendly wait staff, and terrific prices."
457	149	1	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
458	149	1	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
460	150	3	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
461	150	3	"the ambiance and decor excellent."
462	150	3	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
463	151	10	"They had us at the complimentary bowl of lentil soup--the chef's special."
464	151	10	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
465	151	10	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
466	152	6	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
467	152	6	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
468	152	6	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
469	153	6	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
470	153	6	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
471	153	6	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
472	154	9	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
473	154	9	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
474	154	9	"They had us at the complimentary bowl of lentil soup--the chef's special."
475	155	5	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
476	155	5	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
477	155	5	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
478	156	9	"Cozy dining room, friendly wait staff, and terrific prices."
479	156	9	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
480	156	9	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
481	157	8	"They had us at the complimentary bowl of lentil soup--the chef's special."
482	157	8	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
483	157	8	"the food was brilliant."
484	158	9	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
485	158	9	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
486	158	9	"This charming little restaurant serves terrific food in a cozy environment."
487	159	2	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
488	159	2	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
489	159	2	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
490	160	8	"the ambiance and decor excellent."
491	160	8	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
492	160	8	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
493	161	3	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
494	161	3	"the ambiance and decor excellent."
495	161	3	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
496	162	9	"Great place for lunch or dinner."
497	162	9	"This charming little restaurant serves terrific food in a cozy environment."
498	162	9	"Cozy dining room, friendly wait staff, and terrific prices."
499	163	9	"Great place for lunch or dinner."
500	163	9	"the ambiance and decor excellent."
501	163	9	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
502	164	4	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
503	164	4	"Great place for lunch or dinner."
504	164	4	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
505	165	10	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
506	165	10	"Great place for lunch or dinner."
507	165	10	"the food was brilliant."
508	166	3	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
509	166	3	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
510	166	3	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
511	167	4	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
512	167	4	"the ambiance and decor excellent."
513	167	4	"Great place for lunch or dinner."
514	168	7	"the ambiance and decor excellent."
515	168	7	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
516	168	7	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
517	169	2	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
518	169	2	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
519	169	2	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
520	170	5	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
521	170	5	"the food was brilliant."
522	170	5	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
523	171	3	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
524	171	3	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
525	171	3	"the food was brilliant."
526	172	3	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
527	172	3	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
528	172	3	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
529	173	9	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
530	173	9	"They had us at the complimentary bowl of lentil soup--the chef's special."
531	173	9	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
532	174	9	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
533	174	9	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
534	174	9	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
535	175	8	"Great place for lunch or dinner."
536	175	8	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
537	175	8	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
538	176	7	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
539	176	7	"the ambiance and decor excellent."
540	176	7	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
541	177	8	"the food was brilliant."
542	177	8	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
543	177	8	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
544	178	3	"Great place for lunch or dinner."
545	178	3	"They had us at the complimentary bowl of lentil soup--the chef's special."
546	178	3	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
547	179	9	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
548	179	9	"They had us at the complimentary bowl of lentil soup--the chef's special."
549	179	9	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
550	180	4	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
551	180	4	"the ambiance and decor excellent."
552	180	4	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
553	181	8	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
554	181	8	"They had us at the complimentary bowl of lentil soup--the chef's special."
555	181	8	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
556	182	2	"Cozy dining room, friendly wait staff, and terrific prices."
557	182	2	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
558	182	2	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
559	183	4	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
560	183	4	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
561	183	4	"the ambiance and decor excellent."
562	184	7	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
563	184	7	"the ambiance and decor excellent."
564	184	7	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
565	185	6	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
566	185	6	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
567	185	6	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
568	186	3	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
569	186	3	"the ambiance and decor excellent."
570	186	3	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
571	187	1	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
572	187	1	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
573	187	1	"They had us at the complimentary bowl of lentil soup--the chef's special."
574	188	7	"This charming little restaurant serves terrific food in a cozy environment."
575	188	7	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
576	188	7	"Cozy dining room, friendly wait staff, and terrific prices."
578	189	1	"the food was brilliant."
579	189	1	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
621	203	10	"They had us at the complimentary bowl of lentil soup--the chef's special."
580	190	4	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
581	190	4	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
582	190	4	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
583	191	7	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
584	191	7	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
585	191	7	"the food was brilliant."
586	192	7	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
587	192	7	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
588	192	7	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
589	193	7	"the ambiance and decor excellent."
590	193	7	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
591	193	7	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
592	194	10	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
593	194	10	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
594	194	10	"Cozy dining room, friendly wait staff, and terrific prices."
595	195	5	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
596	195	5	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
597	195	5	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
598	196	4	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
599	196	4	"This charming little restaurant serves terrific food in a cozy environment."
600	196	4	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
601	197	8	"Cozy dining room, friendly wait staff, and terrific prices."
602	197	8	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
603	197	8	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
604	198	4	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
605	198	4	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
606	198	4	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
607	199	6	"They had us at the complimentary bowl of lentil soup--the chef's special."
608	199	6	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
609	199	6	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
610	200	6	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
611	200	6	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
612	200	6	"They had us at the complimentary bowl of lentil soup--the chef's special."
613	201	2	"the food was brilliant."
614	201	2	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
615	201	2	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
616	202	6	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
617	202	6	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
618	202	6	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
619	203	10	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
622	204	2	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
623	204	2	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
624	204	2	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
625	205	8	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
626	205	8	"the food was brilliant."
627	205	8	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
628	206	10	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
629	206	10	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
630	206	10	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
631	207	4	"This charming little restaurant serves terrific food in a cozy environment."
632	207	4	"Great place for lunch or dinner."
633	207	4	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
634	208	5	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
635	208	5	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
636	208	5	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
637	209	4	"the food was brilliant."
638	209	4	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
639	209	4	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
640	210	4	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
641	210	4	"Cozy dining room, friendly wait staff, and terrific prices."
642	210	4	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
643	211	4	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
644	211	4	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
645	211	4	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
646	212	4	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
647	212	4	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
648	212	4	"Cozy dining room, friendly wait staff, and terrific prices."
649	213	9	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
650	213	9	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
651	213	9	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
652	214	2	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
653	214	2	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
654	214	2	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
655	215	9	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
656	215	9	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
657	215	9	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
658	216	9	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
659	216	9	"This charming little restaurant serves terrific food in a cozy environment."
660	216	9	"the food was brilliant."
662	217	2	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
663	217	2	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
664	218	7	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
665	218	7	"Cozy dining room, friendly wait staff, and terrific prices."
666	218	7	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
667	219	6	"Great place for lunch or dinner."
668	219	6	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
669	219	6	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
670	220	6	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
671	220	6	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
672	220	6	"the food was brilliant."
673	221	10	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
674	221	10	"Cozy dining room, friendly wait staff, and terrific prices."
675	221	10	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
676	222	7	"the food was brilliant."
677	222	7	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
678	222	7	"They had us at the complimentary bowl of lentil soup--the chef's special."
679	223	2	"Great place for lunch or dinner."
680	223	2	"Cozy dining room, friendly wait staff, and terrific prices."
681	223	2	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
682	224	7	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
683	224	7	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
684	224	7	"They had us at the complimentary bowl of lentil soup--the chef's special."
685	225	2	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
686	225	2	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
687	225	2	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
688	226	8	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
689	226	8	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
690	226	8	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
691	227	10	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
692	227	10	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
693	227	10	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
694	228	5	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
695	228	5	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
696	228	5	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
697	229	1	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
698	229	1	"They had us at the complimentary bowl of lentil soup--the chef's special."
699	229	1	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
700	230	8	"the ambiance and decor excellent."
775	255	5	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
701	230	8	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
702	230	8	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
703	231	5	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
704	231	5	"This charming little restaurant serves terrific food in a cozy environment."
705	231	5	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
706	232	3	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
707	232	3	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
708	232	3	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
709	233	10	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
710	233	10	"Cozy dining room, friendly wait staff, and terrific prices."
711	233	10	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
712	234	3	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
713	234	3	"Cozy dining room, friendly wait staff, and terrific prices."
714	234	3	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
715	235	2	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
716	235	2	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
717	235	2	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
718	236	9	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
719	236	9	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
720	236	9	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
721	237	7	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
722	237	7	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
723	237	7	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
724	238	10	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
725	238	10	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
726	238	10	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
727	239	6	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
728	239	6	"Great place for lunch or dinner."
729	239	6	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
730	240	6	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
731	240	6	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
732	240	6	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
733	241	6	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
734	241	6	"They had us at the complimentary bowl of lentil soup--the chef's special."
735	241	6	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
736	242	4	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
888	292	4	"the food was brilliant."
737	242	4	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
738	242	4	"the food was brilliant."
739	243	4	"They had us at the complimentary bowl of lentil soup--the chef's special."
740	243	4	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
741	243	4	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
742	244	1	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
746	245	1	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
747	245	1	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
748	246	8	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
749	246	8	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
750	246	8	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
751	247	7	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
752	247	7	"They had us at the complimentary bowl of lentil soup--the chef's special."
753	247	7	"the food was brilliant."
754	248	6	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
755	248	6	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
756	248	6	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
757	249	3	"Great place for lunch or dinner."
758	249	3	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
759	249	3	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
760	250	10	"Great place for lunch or dinner."
761	250	10	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
762	250	10	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
763	251	6	"Cozy dining room, friendly wait staff, and terrific prices."
764	251	6	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
765	251	6	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
766	252	3	"Cozy dining room, friendly wait staff, and terrific prices."
767	252	3	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
768	252	3	"This charming little restaurant serves terrific food in a cozy environment."
769	253	9	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
770	253	9	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
771	253	9	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
772	254	1	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
773	254	1	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
774	254	1	"the ambiance and decor excellent."
776	255	5	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
777	255	5	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
778	256	4	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
779	256	4	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
780	256	4	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
781	257	7	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
782	257	7	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
783	257	7	"Great place for lunch or dinner."
784	258	7	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
785	258	7	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
786	258	7	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
787	259	4	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
788	259	4	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
789	259	4	"Great place for lunch or dinner."
790	260	7	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
791	260	7	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
792	260	7	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
793	261	2	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
794	261	2	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
795	261	2	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
796	262	5	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
797	262	5	"the ambiance and decor excellent."
798	262	5	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
799	263	10	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
800	263	10	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
801	263	10	"Great place for lunch or dinner."
802	264	10	"the ambiance and decor excellent."
803	264	10	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
804	264	10	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
805	265	2	"They had us at the complimentary bowl of lentil soup--the chef's special."
806	265	2	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
807	265	2	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
808	266	6	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
809	266	6	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
810	266	6	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
811	267	9	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
812	267	9	"the food was brilliant."
813	267	9	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
814	268	6	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
815	268	6	"the food was brilliant."
816	268	6	"the ambiance and decor excellent."
817	269	9	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
818	269	9	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
819	269	9	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
820	270	3	"the ambiance and decor excellent."
821	270	3	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
822	270	3	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
823	271	4	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
824	271	4	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
825	271	4	"the food was brilliant."
826	272	5	"the ambiance and decor excellent."
827	272	5	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
828	272	5	"Great place for lunch or dinner."
829	273	1	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
830	273	1	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
831	273	1	"the ambiance and decor excellent."
832	274	7	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
833	274	7	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
834	274	7	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
835	275	1	"the food was brilliant."
836	275	1	"the ambiance and decor excellent."
837	275	1	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
838	276	8	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
839	276	8	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
840	276	8	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
841	277	7	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
842	277	7	"Great place for lunch or dinner."
843	277	7	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
844	278	2	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
845	278	2	"the ambiance and decor excellent."
846	278	2	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
847	279	6	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
848	279	6	"This charming little restaurant serves terrific food in a cozy environment."
849	279	6	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
850	280	10	"Cozy dining room, friendly wait staff, and terrific prices."
851	280	10	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
852	280	10	"Great place for lunch or dinner."
853	281	5	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
854	281	5	"the ambiance and decor excellent."
855	281	5	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
856	282	9	"I had never had dolmas before. The barista explained that they were savory stuffed grape leaves, and even brought out a free sample."
857	282	9	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
858	282	9	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
859	283	8	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
860	283	8	"the food was brilliant."
861	283	8	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
862	284	4	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
863	284	4	"the food was brilliant."
864	284	4	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
865	285	10	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
866	285	10	"Great place for lunch or dinner."
867	285	10	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
868	286	1	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
869	286	1	"the food was brilliant."
870	286	1	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
871	287	5	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
872	287	5	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
873	287	5	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
874	288	2	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
875	288	2	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
876	288	2	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
877	289	7	"the food was brilliant."
878	289	7	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
879	289	7	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
880	290	7	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
881	290	7	"This charming little restaurant serves terrific food in a cozy environment."
882	290	7	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
883	291	4	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
884	291	4	"Four adults and two kids, a short wait and bam - glasses with lids for the kids, beers for the grownups and awesome tacos. Staff were great."
885	291	4	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
886	292	4	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
887	292	4	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
889	293	5	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
890	293	5	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
891	293	5	"the food was brilliant."
892	294	5	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
893	294	5	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
894	294	5	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
895	295	2	"Cozy dining room, friendly wait staff, and terrific prices."
896	295	2	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
897	295	2	"the food was brilliant."
898	296	4	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
899	296	4	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
900	296	4	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
901	297	5	"It’s a great time to be a pizza lover in the Bay Area. We’re seeing all sorts of intriguing toppings from a unique New Jersey pork product to autumnal squash to a rapidly growing egg-topped breakfast pie movement. None of these pizzas fit a particular style either. Neapolitan, deep-dish and oblong crackery-crust fans will all be thrilled. Here are 10 of the most exciting pizzas being sliced in the Bay Area right now."
902	297	5	"the ambiance and decor excellent."
903	297	5	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
904	298	6	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
905	298	6	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
906	298	6	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
907	299	3	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
908	299	3	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
909	299	3	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
910	300	1	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
911	300	1	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
912	300	1	"Great place for lunch or dinner."
913	301	8	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
914	301	8	"the ambiance and decor excellent."
915	301	8	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
916	302	10	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
917	302	10	"This charming little restaurant serves terrific food in a cozy environment."
918	302	10	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
919	303	8	"Great place for lunch or dinner."
920	303	8	"Cozy dining room, friendly wait staff, and terrific prices."
921	303	8	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
922	304	7	"Great place for lunch or dinner."
923	304	7	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
924	304	7	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
925	305	6	"This charming little restaurant serves terrific food in a cozy environment."
926	305	6	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
927	305	6	"Cozy dining room, friendly wait staff, and terrific prices."
928	306	5	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
929	306	5	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
930	306	5	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
931	307	3	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
932	307	3	"Cozy dining room, friendly wait staff, and terrific prices."
933	307	3	"The restaurant became noisier as the evening progressed but because we were in one of the intimate side sections, the noise never became overwhelming."
934	308	1	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
935	308	1	"Cozy dining room, friendly wait staff, and terrific prices."
936	308	1	"the ambiance and decor excellent."
937	309	2	"Had a business lunch for 4 and food was outstandingly. After ordering shrimp balls, lobster wrapped with a daikon like veggie and served on a green sauce, pork dumplings and fried rice."
938	309	2	"My girlfriend and I both felt that the clam chowder broth was really thin and not as creamy and thick as previous trips"
939	309	2	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
940	310	7	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
941	310	7	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
942	310	7	"I was traveling alone on business and was dying for some great sushi. Walked a few blocks and saw a big line out the door. I waited awhile and a nice server noticed I was alone and quickly seated me at the bar. The place is fast paced and loud but the staff were quite attentive to me."
943	311	8	"Gotta love this place. Its popular, but worth the wait. They have a great menu...the tea leaf salad is AMAZING. I haven't tried much of the menu, but my friends all loved everything that they had as well. Highly recommended!"
944	311	8	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
945	311	8	"This charming little restaurant serves terrific food in a cozy environment. The food is wonderful and the wait staff is attentive and friendly."
946	312	8	"I loved the food.. but get there early as they do not take reservations and it's a very popular place! I had the tea leave salad, very tasty and first experience for me. Then the pork belly chili.. very tasteful and only medium spicy. Loved the food accompanied by a ginger lemon beer. Definitely go here!"
947	312	8	"We had to wait for about 1 hour for a small table inside, however the food was delicious."
948	312	8	"We went to this cute restaurant for lunch. Reached in time as they close at 3 pm for lunch. Ordered some mice salad and samosas for starters. For the main course ordered tofu noodles, prawns with walnuts, okra and egg curry and a chicken dish. All were excellent. Also had coconut rice and brown rice."
949	313	4	"Went for lunch. Just a short wait (about 10 minutes) to get a table."
950	313	4	"the food was brilliant."
951	313	4	"They had us at the complimentary bowl of lentil soup--the chef's special."
952	314	9	"They had us at the complimentary bowl of lentil soup--the chef's special."
953	314	9	"The restaurant is pretty small – not a lot of seating. We were here at the prime time of lunch but, surprisingly, only had to wait 20 minutes."
954	314	9	"Not impressed with the waiting time (1h) nor the taste of my food. Ordered: Tea Leaf Salad Prawn dish sautéed in dried chilli & onions? ( Don't remember - Sorry) Coconut rice Iced Lychee Tea To be fair, I am from SEA and the prawn dish and coconut rice are very similar to what I have back at home."
955	315	2	"the ambiance and decor excellent."
956	315	2	"I came here by myself one night. I got a Kona Longboard, a salmon poke bowl, and sweet potato fries with an aioli. It was fairly busy, but my food came quick and the workers were nice. It was a cool place to come, on a nice street."
957	315	2	"We were pleasantly surprised by their wine list selection - wow! My favorites were the beef tenderloin and the four vegetable treasure with a few other dishes which we enjoyed with Cakebread Cabernet - yummy!!"
958	98	1	qwqwr
959	98	1	wrrqwr
960	98	1	I like this restarurant
961	1	3	I like it a lot!
\.


--
-- Name: comments_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('comments_comment_id_seq', 961, true);


--
-- Data for Name: cuisine; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY cuisine (cuisine_id, type) FROM stdin;
1	Japanese
2	Chinese
3	Korean
4	Indian
5	Vietnamese
6	Thai
7	Middle Eastern
\.


--
-- Name: cuisine_cuisine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('cuisine_cuisine_id_seq', 7, true);


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY favorites (id, user_id, restaurant_id) FROM stdin;
1	3	7
2	3	47
5	3	129
7	3	12
8	4	5
9	4	101
11	3	91
12	3	2
13	3	292
14	1	4
16	1	14
\.


--
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('favorites_id_seq', 16, true);


--
-- Data for Name: popularity; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY popularity (id, user_id, comment_id, restaurant_id) FROM stdin;
176	3	\N	3
177	3	\N	292
178	3	\N	8
179	3	\N	18
180	3	\N	107
182	1	\N	98
183	3	\N	91
185	3	\N	4
186	3	\N	14
187	3	\N	318
123	4	\N	101
124	4	\N	3
125	3	\N	67
132	3	\N	7
135	9	\N	1
150	2	\N	5
152	2	\N	46
153	2	\N	1
154	1	\N	136
107	4	\N	5
160	1	\N	1
166	1	\N	5
170	3	\N	2
\.


--
-- Name: popularity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('popularity_id_seq', 187, true);


--
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY ratings (rating_id, user_id, restaurant_id, cleanliness, quality, atmosphere, consistency) FROM stdin;
1	3	129	5	5	5	5
2	1	98	4	5	3	1
3	3	1	2	4	5	3
\.


--
-- Name: ratings_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('ratings_rating_id_seq', 3, true);


--
-- Data for Name: restaurants; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY restaurants (restaurant_id, name, yelp_id, yelp_rating, image, latitude, longitude, cuisine_id) FROM stdin;
1	Ichido	ichido-san-francisco-6	5	https://s3-media2.fl.yelpcdn.com/bphoto/CFOfW0h6iwImiU-fUgF9dA/o.jpg	37.7771497000000025	-122.412188599999993	1
2	KUSAKABE	kusakabe-san-francisco	5	https://s3-media3.fl.yelpcdn.com/bphoto/G2S8Lk72iXwnd35Yr86k_g/o.jpg	37.7957017702111031	-122.402884835582	1
3	Shizen Vegan Sushi Bar & Izakaya	shizen-vegan-sushi-bar-and-izakaya-san-francisco	5	https://s3-media4.fl.yelpcdn.com/bphoto/Y7uw71LoOqPg39wG1QABWw/o.jpg	37.768309600000002	-122.421666900000005	1
4	Yume Sushi	yume-sushi-alameda	5	https://s3-media3.fl.yelpcdn.com/bphoto/u3Znp_ziijkCUNKoLsDUXw/o.jpg	37.7648200000000003	-122.241969999999995	1
5	Saru Sushi Bar	saru-sushi-bar-san-francisco	5	https://s3-media1.fl.yelpcdn.com/bphoto/5-ugy01zjSvudVsfdhmCsA/o.jpg	37.7517059999999987	-122.428828300000006	1
6	Kiraku	kiraku-berkeley	5	https://s3-media1.fl.yelpcdn.com/bphoto/mnf1iVpCRpe5k3GDL0bwOw/o.jpg	37.8636830000000018	-122.258976000000004	1
7	Wako Japanese Restaurant	wako-japanese-restaurant-san-francisco	5	https://s3-media3.fl.yelpcdn.com/bphoto/O1mHQIRCpJnPaEdwFQs17g/o.jpg	37.782829999999997	-122.461479999999995	1
8	Omakase	omakase-san-francisco	5	https://s3-media2.fl.yelpcdn.com/bphoto/Am_E8nodPvtQlrRV5ImvUg/o.jpg	37.770389999999999	-122.402690000000007	1
9	An Japanese Restaurant	an-japanese-restaurant-san-francisco-2	5	https://s3-media1.fl.yelpcdn.com/bphoto/WgEal442NmmeD3VNabcOog/o.jpg	37.7850737295731989	-122.428939975798002	1
10	Hot Zushi	hot-zushi-san-francisco	5	https://s3-media1.fl.yelpcdn.com/bphoto/p5gNXgxkycScSnnmHY51dg/o.jpg	37.7718463870563994	-122.430961020290994	1
11	Sushi Zone	sushi-zone-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/eRpMi-BUuK9pQL1P045lXg/o.jpg	37.7712300000000027	-122.423739999999995	1
12	Tsubasa Sushi	tsubasa-sushi-san-francisco	5	https://s3-media3.fl.yelpcdn.com/bphoto/xqCPlBn9qKl5a_QWGLjH0g/o.jpg	37.7772199999999998	-122.423299999999998	1
13	Elephant Sushi Golden Gate	elephant-sushi-golden-gate-san-francisco-6	5	https://s3-media4.fl.yelpcdn.com/bphoto/-Da8eTZnSgwRtEEVer-yhw/o.jpg	37.7815063999999978	-122.416953899999996	1
14	Kiss Seafood	kiss-seafood-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/tu_X-Lj7ZuJVJjEcr73IxA/o.jpg	37.7868853571262022	-122.428210058860998	1
15	Koo	koo-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/SidlRmQFGrJhcU1yGRkvAw/o.jpg	37.7643585480110033	-122.462438279460002	1
16	Daigo Sushi	daigo-sushi-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/f-L2rlvMpso0U_pM5qv31A/o.jpg	37.7822188999999966	-122.485740699999994	1
17	Elephant Sushi	elephant-sushi-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/QBvVZhvB3ttC5Ibfx8ZnSg/o.jpg	37.7986359967903027	-122.418817175786998	1
18	Sushi Time	sushi-time-san-francisco-2	4	https://s3-media2.fl.yelpcdn.com/bphoto/qNRO-GmfBpkmVfjO9PORXw/o.jpg	37.7645499999999998	-122.432060000000007	1
19	Ijji Sushi	ijji-sushi-san-francisco	5	https://s3-media2.fl.yelpcdn.com/bphoto/Wvndom7vD5cjnQrqerBMcA/o.jpg	37.7713940000000008	-122.437031000000005	1
20	Sushi Ran	sushi-ran-sausalito	4	https://s3-media3.fl.yelpcdn.com/bphoto/z2o5c-TqR6xHk1pWjtGV_g/o.jpg	37.8584999999999994	-122.485950000000003	1
21	Geta	geta-oakland	4	https://s3-media2.fl.yelpcdn.com/bphoto/vQX5tQnT9SKxE9f-FTjOWA/o.jpg	37.8265990000000016	-122.252902000000006	1
22	Tekka Japanese Restaurant	tekka-japanese-restaurant-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/FdgRZzwJLpe_fM7F6n8big/o.jpg	37.7770524000000023	-122.464718300000001	1
23	Takoba	takoba-san-francisco	5	https://s3-media2.fl.yelpcdn.com/bphoto/GJBL9MxXsHWIXIlktWuT_w/o.jpg	37.7870399999999975	-122.400440000000003	1
24	Kabuto Restaurant	kabuto-restaurant-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/P4HCpfpFYWLyCnYIowTjLQ/o.jpg	37.7803600000000017	-122.474400000000003	1
25	Yo Yo's	yo-yos-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/8siRMb5j_ccugSXHhuHIcQ/o.jpg	37.797702543974701	-122.401235478538993	1
26	Zushi Puzzle	zushi-puzzle-san-francisco-2	4	https://s3-media1.fl.yelpcdn.com/bphoto/lyVzlodrIv4CZycyxu0_4w/o.jpg	37.8005199999999988	-122.433080000000004	1
27	jū-ni	jū-ni-san-francisco-5	5	https://s3-media3.fl.yelpcdn.com/bphoto/8q571XxVjpvMRroqPWlLiA/o.jpg	37.7766415225093013	-122.438843362032998	1
28	Nara Restaurant & Sake Bar	nara-restaurant-and-sake-bar-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/7zzlpJKaC9bndjuo2UIr6g/o.jpg	37.7721665317965005	-122.430675700307006	1
29	Roka Akor	roka-akor-san-francisco-4	4	https://s3-media3.fl.yelpcdn.com/bphoto/TG7q5xBYTlnxknKc4c-Yog/o.jpg	37.7965391394847998	-122.403850511802005	1
30	Nabe	nabe-san-francisco-3	4	https://s3-media1.fl.yelpcdn.com/bphoto/jW9NDCforrIBjt6Yx1SiXA/o.jpg	37.7636930075875981	-122.466346937888005	1
31	Okoze Sushi	okoze-sushi-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/epYqe4-8YK8tYaL5ZQK2Nw/o.jpg	37.7989900000000034	-122.419290000000004	1
32	Kamado Sushi	kamado-sushi-berkeley	4	https://s3-media3.fl.yelpcdn.com/bphoto/_MIYwPpGDZl4KTVavu6AjA/o.jpg	37.8818319209494021	-122.269697226584	1
33	Abura - Ya Japanese Fried Chicken	abura-ya-japanese-fried-chicken-oakland	4	https://s3-media4.fl.yelpcdn.com/bphoto/petcWfWib4GPr_tdGQI_2A/o.jpg	37.8048241942875975	-122.269008155609001	1
34	Shimizu Sushi	shimizu-sushi-oakland	4	https://s3-media1.fl.yelpcdn.com/bphoto/R-jDfZqRjetAmAWTRAnCBg/o.jpg	37.8284415999999979	-122.249336200000002	1
35	Kazan	kazan-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/8HlfX05Vg9fHs73ySDBdZA/o.jpg	37.7526399999999995	-122.408439999999999	1
36	Eiji	eiji-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/e3K6TLM1fFRi_lvRlCwOAw/o.jpg	37.7641840000000002	-122.430593000000002	1
37	Tataki	tataki-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/W_TIrJ8bWpxT4cBRfTDfTQ/o.jpg	37.787852700000002	-122.441045000000003	1
38	Ippuku	ippuku-berkeley-2	4	https://s3-media2.fl.yelpcdn.com/bphoto/JJbIfTd7lwGafcqf2PtJWQ/o.jpg	37.8702699999999979	-122.267020000000002	1
39	Wayo Sushi	wayo-sushi-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/ZWfsFkVmHqHp0JFyIOe08A/o.jpg	37.7887079999999997	-122.422173999999998	1
40	Muracci's Japanese Curry & Grill	muraccis-japanese-curry-and-grill-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/mktpaCbXsJh3--lpEgHc5g/o.jpg	37.7908899999999974	-122.404259999999994	1
41	Okina Sushi	okina-sushi-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/VokpAdSRZDx69wyunxBzmA/o.jpg	37.775739999999999	-122.458119999999994	1
42	ZEN Asian Fusion Tapas & Lounge	zen-asian-fusion-tapas-and-lounge-alameda-2	4	https://s3-media3.fl.yelpcdn.com/bphoto/j03Jq2MoLLhO4SegSoxXjQ/o.jpg	37.7659499000000025	-122.242500000000007	1
43	Sugoi Sushi	sugoi-sushi-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/ke-g-CWl3_Z0HFPeqXD6Dw/o.jpg	37.7544594000000018	-122.421188400000005	1
44	Ebisu	ebisu-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/VApvijD4bgLAg5AkM9uR4g/o.jpg	37.764454716932903	-122.466417011814002	1
45	Sushi Bistro	sushi-bistro-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/Uo9YbTWfVTVlwJIoGwk1yA/o.jpg	37.7771100000000004	-122.463489999999993	1
46	The House	the-house-san-francisco	5	https://s3-media4.fl.yelpcdn.com/bphoto/dDYNFB86xKF2g5PXCi1RTw/o.jpg	37.7986203000000032	-122.407025099999998	2
47	Hai Ky Mi Gia	hai-ky-mi-gia-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/0dx8AHeL2OYsp84xXLL-RA/o.jpg	37.784080000000003	-122.417950000000005	2
48	Good Mong Kok Bakery	good-mong-kok-bakery-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/Wndwx-kui0DexPf3rcwz_A/o.jpg	37.7954584839809016	-122.408358365012006	2
49	Superstar Restaurant	superstar-restaurant-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/BjZx4YI0sQO73zH47Jk3_Q/o.jpg	37.7195200000000028	-122.438339999999997	2
50	San Tung	san-tung-san-francisco-2	4	https://s3-media4.fl.yelpcdn.com/bphoto/P5_EgBQbRm9Am9Mmynvwxw/o.jpg	37.7636699999999976	-122.468959999999996	2
51	Hunan Cafe 2	hunan-cafe-2-san-francisco-2	4	https://s3-media1.fl.yelpcdn.com/bphoto/2tohI6f7Mjs8poq55BXfpQ/o.jpg	37.7736200000000011	-122.506659999999997	2
52	Thai Nghiep Ky Mi Gia	thai-nghiep-ky-mi-gia-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/uePtFAIGkuMYxMufVYg97g/o.jpg	37.7539242833532001	-122.479033808170001	2
53	Hakkasan	hakkasan-san-francisco-2	4	https://s3-media2.fl.yelpcdn.com/bphoto/NEDgv2eNNlJ5-VhN5zu9ZA/o.jpg	37.7880522999999968	-122.403687099999999	2
54	House Of Pancakes	house-of-pancakes-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/swPpKYMK37n5pPxcpfdeqg/o.jpg	37.7428700000000035	-122.476399999999998	2
55	Yummy Yummy	yummy-yummy-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/iNtuo93WsV9t8dU3Njiwbw/o.jpg	37.7636800000000008	-122.468789999999998	2
56	Kung Food	kung-food-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/NE9-r2LiDp59EcFXiEx4bQ/o.jpg	37.7776557732482985	-122.438782954299	2
57	Sichuan Home	sichuan-home-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/q0qEtWtgmaw0Re4z6dt8uQ/o.jpg	37.7804031000000009	-122.473655699999995	2
58	Yan's Kitchen	yans-kitchen-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/_iI_NtR6KzChctxZVXV2Jg/o.jpg	37.7961200000000019	-122.40437	2
59	Boiling Hot Pot	boiling-hot-pot-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/XTtHsyPExgJLw6qh3UrEKg/o.jpg	37.7806682000000009	-122.478699199999994	2
60	Dumpling Kitchen	dumpling-kitchen-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/5mUKAyVQd7FM0u9rLI8Fdw/o.jpg	37.7422980999999993	-122.4870071	2
61	SO	so-san-francisco-4	4	https://s3-media3.fl.yelpcdn.com/bphoto/D9pxFfw9vDsb03w08VzwYw/o.jpg	37.7724100000000007	-122.407499999999999	2
62	Henry's Hunan Restaurant	henrys-hunan-restaurant-san-francisco-7	4	https://s3-media2.fl.yelpcdn.com/bphoto/HNB-ihtOYPyEajqDopJ88g/o.jpg	37.7996560010964018	-122.407288671122998	2
63	Sam Wo Restaurant	sam-wo-restaurant-san-francisco-3	4	https://s3-media2.fl.yelpcdn.com/bphoto/5mOEmllmTcoJ3xpmLrHAmg/o.jpg	37.7942898000000014	-122.404979900000001	2
64	Delicious Dim Sum	delicious-dim-sum-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/47a_EutfnYi0F9RXQhJS2w/o.jpg	37.7960509999999985	-122.407600400000007	2
65	Wok Shop Cafe	wok-shop-cafe-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/VEmp8GJPzFc5Xc-7wjHcqQ/o.jpg	37.7873543999999981	-122.422083099999995	2
66	Henry Hunan Restaurant	henry-hunan-restaurant-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/7KmnKrUTUyifWEAQ3KEZpA/o.jpg	37.7434099999999972	-122.426919999999996	2
67	Sun Kwong Restaurant	sun-kwong-restaurant-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/TZbM7IFWYDreL-CTJxIn4Q/o.jpg	37.794710000000002	-122.418350000000004	2
68	IPOT	ipot-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/igecj5WFYB26_fQYDLz8aQ/o.jpg	37.7638799551143975	-122.473210170865002	2
69	Cheung Hing	cheung-hing-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/otmJXErWWhlr1rn4gaaD1Q/o.jpg	37.7534300000000016	-122.488919999999993	2
70	Good Luck Dim Sum	good-luck-dim-sum-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/kkw7J9MEM2q3fNnRn4xakA/o.jpg	37.7829699999999988	-122.467179999999999	2
71	New Golden Daisy	new-golden-daisy-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/MZnDZ6og7XPEJbqu5nlkhg/o.jpg	37.7955400000000026	-122.408479999999997	2
72	J & A Restaurant	j-and-a-restaurant-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/6zjL6MOzTNQ3DynRjtJYtw/o.jpg	37.7100369999999998	-122.449871999999999	2
73	Yamo	yamo-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/4WORqiY1rU2EXC4YKdB4iQ/o.jpg	37.761946334387801	-122.419764563536006	2
74	Kim Thanh Restaurant	kim-thanh-restaurant-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/KDhuPWHO0jpRbitaRNVEMQ/o.jpg	37.7865731999999994	-122.413391799999999	2
75	Hunan Home's Restaurant	hunan-homes-restaurant-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/hIQm9kNtu-WUs2jGFVSgrQ/o.jpg	37.7962599000000026	-122.405609999999996	2
76	Henry's Hunan Restaurant	henrys-hunan-restaurant-san-francisco-6	4	https://s3-media2.fl.yelpcdn.com/bphoto/PgHsqAWWNy6-Pu_OLWqcHg/o.jpg	37.7221100000000007	-122.436400000000006	2
77	New Lun Ting Cafe	new-lun-ting-cafe-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/pj-516zBoOzLeetA1ZUg0w/o.jpg	37.7961166251020018	-122.406260706650002	2
78	Kingdom of Dumpling	kingdom-of-dumpling-san-francisco-2	4	https://s3-media3.fl.yelpcdn.com/bphoto/IZ1PV8Sn8w0R4LiY9vJXyw/o.jpg	37.7424600303506992	-122.484634144180006	2
79	R&G Lounge	r-and-g-lounge-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/y_1vkP2oCpY2eNfy9vArpw/o.jpg	37.7941240989441027	-122.404937406342	2
80	Taste of Jiangnan	taste-of-jiangnan-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/_i5SyePIp_UzpVf-9PEEFg/o.jpg	37.7831699999999984	-122.462900000000005	2
81	Wonderland Restaurant	wonderland-restaurant-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/1gQjSLD3A5gS3B7ipaD8fg/o.jpg	37.7723429999999993	-122.430614000000006	2
82	Mister Jiu's	mister-jius-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/yr86I2AdcBzWGqfj_a4xqA/o.jpg	37.7937724000000017	-122.406759399999999	2
83	Terra Cotta Warrior	terra-cotta-warrior-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/e2vZEYO_warsw5yFMtcifg/o.jpg	37.7608999999999995	-122.489519999999999	2
84	The Pot's	the-pots-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/vjvYNmuckRQGri0eSl1NQw/o.jpg	37.7612900000000025	-122.490710000000007	2
85	Lai Hong Lounge	lai-hong-lounge-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/ygj5liCcT5RBwftC8r50jw/o.jpg	37.7978516000000013	-122.410118100000005	2
86	Hong Kong Lounge II	hong-kong-lounge-ii-san-francisco-3	4	https://s3-media1.fl.yelpcdn.com/bphoto/PWOl3Y4mqjZmhM4WuSVGsQ/o.jpg	37.7818717999999976	-122.454421999999994	2
87	Dragon Beaux	dragon-beaux-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/8mxf5XdZfb5ZUrqzeItwkA/o.jpg	37.7804985000000002	-122.480697599999999	2
88	Clement BBQ	clement-bbq-san-francisco-2	4	https://s3-media4.fl.yelpcdn.com/bphoto/_B5bPOS_i9IMNEJL6neOAA/o.jpg	37.7827300000000008	-122.465900000000005	2
89	Hong Kong Lounge	hong-kong-lounge-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/yEhj3x-tSt3FabfDezzkgA/o.jpg	37.7806709999999981	-122.476618999999999	2
90	Dim Sum Club	dim-sum-club-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/FUHPYL8YH9qS61hXpQeWpA/o.jpg	37.7991100252966987	-122.423847828202	2
91	Chicken On Fire	chicken-on-fire-hayward	5	https://s3-media3.fl.yelpcdn.com/bphoto/-f0R7DfnnLFmjqfzD0vs_A/o.jpg	37.6278945878243007	-122.098708454844001	3
92	Tacorea	tacorea-san-francisco	5	https://s3-media2.fl.yelpcdn.com/bphoto/7sOn8_P7Hxb0ZkM55tz3mg/o.jpg	37.7897959388507019	-122.410720065236006	3
93	Hot Sauce and Panko	hot-sauce-and-panko-san-francisco	5	https://s3-media4.fl.yelpcdn.com/bphoto/vKQD4EF6xk7_ryHtgiTAJA/o.jpg	37.7945165216684984	-122.417876198887001	3
94	Benu	benu-san-francisco-4	5	https://s3-media2.fl.yelpcdn.com/bphoto/UAN9WLyuD8E37pKDhlpe1g/o.jpg	37.7854019999999977	-122.399068	3
95	Bart Grocery & BBQ	bart-grocery-and-bbq-daly-city	5	https://s3-media3.fl.yelpcdn.com/bphoto/HdJRjqm9mu_hAxd5S14S0g/o.jpg	37.7057799999999972	-122.464100000000002	3
96	HRD	hrd-san-francisco-4	5	https://s3-media4.fl.yelpcdn.com/bphoto/ImvLt9I8ACHwfYthZw8vVw/o.jpg	37.7811065758547997	-122.395329724426006	3
97	Belly	belly-oakland-2	5	https://s3-media3.fl.yelpcdn.com/bphoto/4TxBRTBwerUrfJjUyCBeHA/o.jpg	37.8091386999999983	-122.273111799999995	3
98	First Korean Market	first-korean-market-san-francisco	5	https://s3-media3.fl.yelpcdn.com/bphoto/10LCJGoRZdvarVD8CMn1Ag/o.jpg	37.7805996000000022	-122.469113899999996	3
99	KoJa Kitchen	koja-kitchen-berkeley-2	4	https://s3-media3.fl.yelpcdn.com/bphoto/yxaYSHxb4dLULt-PSn2Rhg/o.jpg	37.8670845999999983	-122.258740900000006	3
100	Art's Cafe	arts-cafe-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/ucKWacz5rff-ce_RZ0sBRQ/o.jpg	37.7639259999999979	-122.465757800000006	3
101	Bowl'd Korean Rice Bar	bowld-korean-rice-bar-albany	4	https://s3-media4.fl.yelpcdn.com/bphoto/f63yxUSXYd4xgAFENPJyHg/o.jpg	37.8910440000000008	-122.288285000000002	3
102	Moa Korean BBQ	moa-korean-bbq-pleasant-hill-2	4	https://s3-media2.fl.yelpcdn.com/bphoto/efz_fAqBZiUGyCJMthVTJQ/o.jpg	37.9801900000000003	-122.068730000000002	3
103	San Tung	san-tung-san-francisco-2	4	https://s3-media4.fl.yelpcdn.com/bphoto/P5_EgBQbRm9Am9Mmynvwxw/o.jpg	37.7636699999999976	-122.468959999999996	3
104	Gogi Time	gogi-time-oakland	4	https://s3-media4.fl.yelpcdn.com/bphoto/KhG6gp1xCxQxfkxLGpaigg/o.jpg	37.8156210000000002	-122.267610000000005	3
105	Pyeongchang Tofu House	pyeongchang-tofu-house-oakland	4	https://s3-media4.fl.yelpcdn.com/bphoto/EMo5ZldTM6Kwaj--ki0Yrw/o.jpg	37.8345100000000016	-122.263400000000004	3
106	Bowl'd BBQ	bowld-bbq-oakland-3	4	https://s3-media1.fl.yelpcdn.com/bphoto/TGWNt8bbCOgkKAyFA0Ct9Q/o.jpg	37.8353439999999992	-122.263000000000005	3
107	Spoon Korean Bistro	spoon-korean-bistro-berkeley	4	https://s3-media3.fl.yelpcdn.com/bphoto/FQjPrRQbkATcpciXMadKrw/o.jpg	37.8516502000000017	-122.289917000000003	3
108	Kukje Super Market	kukje-super-market-daly-city	4	https://s3-media3.fl.yelpcdn.com/bphoto/e-ydbRUuuR-HtIIyK-Lw_g/o.jpg	37.6941611000000023	-122.471164900000005	3
109	Manna	manna-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/3TbyPQWSkwPRaGOIIBdN5A/o.jpg	37.7638396999999983	-122.467079200000001	3
110	Jong Ga House	jong-ga-house-oakland	4	https://s3-media3.fl.yelpcdn.com/bphoto/rIphjCvmGj9z8n6vPfAE-w/o.jpg	37.808971200000002	-122.254723200000001	3
111	Oori Rice Triangles	oori-rice-triangles-albany-3	4	https://s3-media1.fl.yelpcdn.com/bphoto/i9Oe0FloJLv8kFK5FNLAqw/o.jpg	37.8907327309418989	-122.293739964571003	3
112	Mixed Grain	mixed-grain-walnut-creek	4	https://s3-media1.fl.yelpcdn.com/bphoto/7sufaqCYqhLYnro1nxcykw/o.jpg	37.8998626999999999	-122.061996899999997	3
113	Koja Kitchen	koja-kitchen-san-francisco-7	4	https://s3-media4.fl.yelpcdn.com/bphoto/VXWBx_QVZKL-uqUIe2H95g/o.jpg	37.7828615000000028	-122.463106499999995	3
114	KoJa Kitchen	koja-kitchen-berkeley	4	https://s3-media2.fl.yelpcdn.com/bphoto/Pgrf6jL27nX-mWd8z7GE6w/o.jpg	37.8670845999999983	-122.258740900000006	3
115	Korea House	korea-house-concord	4	https://s3-media2.fl.yelpcdn.com/bphoto/JEEsDK2mN4UILLDO9J4iBg/o.jpg	37.9751400000000032	-122.038740000000004	3
116	SO	so-san-francisco-4	4	https://s3-media3.fl.yelpcdn.com/bphoto/D9pxFfw9vDsb03w08VzwYw/o.jpg	37.7724100000000007	-122.407499999999999	3
117	Han Il Kwan	han-il-kwan-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/biPAvaqzovD-gQlHPvhNDA/o.jpg	37.7767499999999998	-122.478300000000004	3
118	Casserole House	casserole-house-oakland	4	https://s3-media3.fl.yelpcdn.com/bphoto/6f7lvCWcYZ6Ne7TBvMiEwA/o.jpg	37.8317300000000003	-122.264120000000005	3
119	Koreana Plaza	koreana-plaza-oakland	4	https://s3-media3.fl.yelpcdn.com/bphoto/5qzCb-WE_Ap8vbfHuIr9ag/o.jpg	37.813574768749298	-122.268007609231006	3
120	Aria - Korean Snack Bar	aria-korean-snack-bar-san-francisco-2	4	https://s3-media1.fl.yelpcdn.com/bphoto/Eeju8NQ_sOinWn6zv2Ty4A/o.jpg	37.7865480000000034	-122.418079500000005	3
121	Gangnam Tofu	gangnam-tofu-el-cerrito-2	4	https://s3-media3.fl.yelpcdn.com/bphoto/70Ywpr2-eJ7p8rLnPLdQ0w/o.jpg	37.9272842075010033	-122.319275999338998	3
122	FuseBox	fusebox-oakland-2	4	https://s3-media3.fl.yelpcdn.com/bphoto/FHYjQB6AnExI8NRh99RCJg/o.jpg	37.8169315630783984	-122.284774130331996	3
123	Mom's Tofu House	moms-tofu-house-south-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/urm4oDdI8Qk0CxUXsQGCSQ/o.jpg	37.6546599999999998	-122.409239999999997	3
124	Jin Mi Korean Cuisine	jin-mi-korean-cuisine-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/9g3ql4XhxmbM5p4C2x-XLQ/o.jpg	37.7815846467306002	-122.416728168692998	3
125	Dan Sung Sa	dan-sung-sa-oakland	4	https://s3-media3.fl.yelpcdn.com/bphoto/MpkOjxiF_sHqX46s15Tg1w/o.jpg	37.8171600000000012	-122.268050000000002	3
126	Muguboka Restaurant	muguboka-restaurant-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/SvGaKUw2L9nbHio1BBMV4A/o.jpg	37.7771299999999997	-122.463170000000005	3
127	My Tofu House	my-tofu-house-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/sAfdHNeMM4AGm1bEwctjcw/o.jpg	37.7806562999999969	-122.469128600000005	3
128	Rice N Roll	rice-n-roll-pacifica	4	https://s3-media4.fl.yelpcdn.com/bphoto/axBseMraaDZQ0deozzRa0A/o.jpg	37.6460434999999976	-122.471685300000004	3
129	Glaze Teriyaki	glaze-teriyaki-san-francisco-3	4	https://s3-media2.fl.yelpcdn.com/bphoto/yNxaHYmT3gaCRjOB87f_QA/o.jpg	37.7879021999999978	-122.433526999999998	3
130	Ohgane Korean Restaurant	ohgane-korean-restaurant-oakland	4	https://s3-media4.fl.yelpcdn.com/bphoto/Kz3AUDVNdpDRpsMqRww8WA/o.jpg	37.8272641000000007	-122.257054199999999	3
131	The Spot Lounge	the-spot-lounge-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/elz5SJM9DgtiAvPLgUqCNQ/o.jpg	37.7421099000000027	-122.491209999999995	3
132	The Sister House	the-sister-house-hayward	4	https://s3-media4.fl.yelpcdn.com/bphoto/8ivV8Cw31eXcArLiWBkNlA/o.jpg	37.6782912999999979	-122.091941800000001	3
133	Toyose	toyose-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/bgQkIeFH4Q36_JBygnz5DQ/o.jpg	37.7531299999999987	-122.504670000000004	3
134	Koryo Jajang	koryo-jajang-oakland	4	https://s3-media2.fl.yelpcdn.com/bphoto/-HfVI3_zxMFVzfhy-eaWYw/o.jpg	37.8320999000000029	-122.263080000000002	3
135	The Crew	the-crew-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/O-zYOYJtPaldODwIdBac1w/o.jpg	37.7543406605786984	-122.478169364417994	3
136	Lotus Chaat and Spices	lotus-chaat-and-spices-san-rafael	5	https://s3-media2.fl.yelpcdn.com/bphoto/YeKi221ee6pvbLF-zhQbQQ/o.jpg	37.9738378999999995	-122.536114299999994	4
137	Kebab King	kebab-king-san-francisco	5	https://s3-media4.fl.yelpcdn.com/bphoto/jGLnA7bbjMXXR58NpJkaDA/o.jpg	37.7797956034191031	-122.431976950296999	4
138	Avatar's Restaurant	avatars-restaurant-sausalito	5	https://s3-media3.fl.yelpcdn.com/bphoto/gbWsbvTI3T-jJUMh7Vhs5g/o.jpg	37.8686903295038988	-122.501987684252995	4
139	Masala Cuisine	masala-cuisine-oakland	5	https://s3-media1.fl.yelpcdn.com/bphoto/DAhyS8aPUHDGTyHvzcH5Mw/o.jpg	37.7570300000000003	-122.181910000000002	4
140	Curry Corner Takeaway	curry-corner-takeaway-hayward	5	https://s3-media4.fl.yelpcdn.com/bphoto/ACxfnxRk06-mfqZ9vD3-aQ/o.jpg	37.6475700000000018	-122.064580000000007	4
141	Himalayan Tandoori & Curry House	himalayan-tandoori-and-curry-house-berkeley	5	https://s3-media1.fl.yelpcdn.com/bphoto/3LzsrfzMV0kG031F44q4Xg/o.jpg	37.8913200000000003	-122.283429999999996	4
142	Rasoi Restaurant & Lounge	rasoi-restaurant-and-lounge-burlingame	5	https://s3-media3.fl.yelpcdn.com/bphoto/HzILOPtfHZ-RDVoRPyodIg/o.jpg	37.5771668160936017	-122.348935492067	4
143	Curry Leaf	curry-leaf-san-francisco	5	https://s3-media3.fl.yelpcdn.com/bphoto/F74K-bnfRGvRDBCmilffew/o.jpg	37.8030800000000013	-122.414519999999996	4
144	Hamro Aangan	hamro-aangan-albany-2	5	https://s3-media4.fl.yelpcdn.com/bphoto/tOUyaqxqzFUbyWENfYMn8w/o.jpg	37.8905446117589975	-122.299254926339998	4
145	All Spice	all-spice-san-mateo-2	5	https://s3-media1.fl.yelpcdn.com/bphoto/zp0dul7wRMkpO3xTcdql2g/o.jpg	37.5528499999999994	-122.315659999999994	4
146	Delhi Diner	delhi-diner-albany	5	https://s3-media2.fl.yelpcdn.com/bphoto/AQP_scct1ZG8vpVedLlvUw/o.jpg	37.8909700000000029	-122.290679999999995	4
147	Burma Superstar	burma-superstar-san-francisco-2	4	https://s3-media2.fl.yelpcdn.com/bphoto/nnDwAZSD38IxWtXlu3VGKg/o.jpg	37.7828900000000019	-122.462530000000001	4
148	Vik's Chaat	viks-chaat-berkeley	4	https://s3-media3.fl.yelpcdn.com/bphoto/RpOPvK-FVzEW5EVbA58DWg/o.jpg	37.8612832889970008	-122.298402438709999	4
149	High Peaks Kitchen	high-peaks-kitchen-oakland-2	4	https://s3-media1.fl.yelpcdn.com/bphoto/20ruLNh02wS00LcLO4NBbA/o.jpg	37.8377662999999984	-122.251424900000004	4
150	Keeva Indian Kitchen	keeva-indian-kitchen-san-francisco	5	https://s3-media1.fl.yelpcdn.com/bphoto/o2lJ7_fPP0XO0X7tX-5wSA/o.jpg	37.7828780156699011	-122.469022889334994	4
151	Rasa	rasa-burlingame	4	https://s3-media4.fl.yelpcdn.com/bphoto/LcwF5IpgOLbp-F_20qvIBQ/o.jpg	37.5772711999999984	-122.345944000000003	4
152	North India Restaurant	north-india-restaurant-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/howYvOKNPXU9A5KUahEXLA/o.jpg	37.7877891246910025	-122.399305736113007	4
153	Viva Goa	viva-goa-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/Olg9e_kyogeQFmB9d9pLYw/o.jpg	37.7992869999999996	-122.441485	4
154	Dakshin	dakshin-san-francisco-6	5	https://s3-media4.fl.yelpcdn.com/bphoto/T71q0Ln4B6sm3Z6RxroM_g/o.jpg	37.7963090824567018	-122.421967573464002	4
155	Prabh Indian Kitchen	prabh-indian-kitchen-mill-valley	4	https://s3-media3.fl.yelpcdn.com/bphoto/Fdu-xesMb4Lp-1HGtSgEYw/o.jpg	37.9057200000000023	-122.546260000000004	4
156	Aroma Cuisine of India	aroma-cuisine-of-india-castro-valley	4	https://s3-media4.fl.yelpcdn.com/bphoto/rfUwsMSoBYo6T81LlXPRUQ/o.jpg	37.6966570000000019	-122.077592999999993	4
157	Lotus Cuisine of India	lotus-cuisine-of-india-san-rafael	4	https://s3-media1.fl.yelpcdn.com/bphoto/V-8_6GYAjnT_n68BovWNgQ/o.jpg	37.9727000000000032	-122.522880000000001	4
158	Mela Tandoori Kitchen	mela-tandoori-kitchen-san-francisco-2	4	https://s3-media4.fl.yelpcdn.com/bphoto/l3kam1K0c6iSe1hTc3iXqA/o.jpg	37.7814102000000034	-122.419517499999998	4
159	A Desi Cafe	a-desi-cafe-san-francisco-3	5	https://s3-media2.fl.yelpcdn.com/bphoto/tKldPBalXbZjGLRbLRBeig/o.jpg	37.7538699999999992	-122.479849999999999	4
160	Flavor of India	flavor-of-india-san-lorenzo	4	https://s3-media3.fl.yelpcdn.com/bphoto/_mnhL36tFDGv0fGFvuArhQ/o.jpg	37.6805311456251033	-122.126802876591995	4
161	BBQ N Curry House	bbq-n-curry-house-sausalito	4	https://s3-media2.fl.yelpcdn.com/bphoto/ghg2xo2jGQodq-GS2ZYPSA/o.jpg	37.8730946000000017	-122.511297299999995	4
162	Campton Place Restaurant	campton-place-restaurant-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/JNBUlpMymzHyrnm9eQ-OOg/o.jpg	37.7891030590382968	-122.406697746033004	4
163	Udupi Palace	udupi-palace-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/HmEQTVS8XgGSWdkhbcU27w/o.jpg	37.7566699999999997	-122.420910000000006	4
164	Tara Indian Cuisine	tara-indian-cuisine-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/NsaJ9H5KA5J55fp33GHxJw/o.jpg	37.7654083999999983	-122.431227100000001	4
165	Deccan Spice	deccan-spice-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/sih4orR0LJRAjpGNpAFrgQ/o.jpg	37.7546800000000005	-122.421189999999996	4
166	Little Nepal	little-nepal-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/7rwZngRe_MsYAEWkTJwMHw/o.jpg	37.7390800000000013	-122.413579999999996	4
167	Red Chilli	red-chilli-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/uYxEQWKDABe9l5WPfB7UaQ/o.jpg	37.7861205999999967	-122.413034600000003	4
168	Taste of the Himalayas	taste-of-the-himalayas-sausalito	4	https://s3-media2.fl.yelpcdn.com/bphoto/R6u6OJM0tmxRH1_-GZ4-8A/o.jpg	37.8685800000000015	-122.503169999999997	4
169	The Dosa Brothers	the-dosa-brothers-san-francisco-4	4	https://s3-media2.fl.yelpcdn.com/bphoto/Q_AnrZZn-0g3fQ4tl72qow/o.jpg	37.7889730999999998	-122.4019531	4
170	Avatar's Restaurant	avatars-restaurant-mill-valley	4	https://s3-media2.fl.yelpcdn.com/bphoto/d8OI_vULqbZBNJNZN0QhIg/o.jpg	37.90578	-122.549430000000001	4
171	The Third Eye Restaurant & Bar	the-third-eye-restaurant-and-bar-millbrae-6	4	https://s3-media2.fl.yelpcdn.com/bphoto/BDCqmWN0U3icCo7xRtgdcw/o.jpg	37.6010584975439031	-122.392263746118999	4
172	Namaste Pizza	namaste-pizza-oakland-2	4	https://s3-media2.fl.yelpcdn.com/bphoto/qZgPZZzNa-yX721M2Y_sBw/o.jpg	37.842880000000001	-122.283330000000007	4
173	Marhaba Indian & Pakistani Halal Cuisine	marhaba-indian-and-pakistani-halal-cuisine-oakland	4	https://s3-media2.fl.yelpcdn.com/bphoto/jMBWs_GCe9cpXoj_36aO4w/o.jpg	37.8045440765693996	-122.269691862165999	4
174	Favorite Indian Restaurant	favorite-indian-restaurant-hayward	4	https://s3-media3.fl.yelpcdn.com/bphoto/RhZSFRJkbRJiCGNTFkJfUw/o.jpg	37.6677492000000029	-122.079487200000003	4
175	Biryani Kabab	biryani-kabab-oakland	4	https://s3-media2.fl.yelpcdn.com/bphoto/W9i_vzYKRlD1-Dy1I_k6Ug/o.jpg	37.8027598999999981	-122.269801099999995	4
176	Aslam's Rasoi	aslams-rasoi-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/6CObic_OkWJtiLexQD_Xng/o.jpg	37.7563000000000031	-122.420879999999997	4
177	Amber India	amber-india-san-francisco-2	4	https://s3-media2.fl.yelpcdn.com/bphoto/OnTuKZbe_2CLnfWhfN9NYA/o.jpg	37.7858090277572032	-122.404539585113994	4
178	Om Indian Cuisine	om-indian-cuisine-san-francisco	5	https://s3-media2.fl.yelpcdn.com/bphoto/-aSVtJSHUnwdaBvqqJMtSQ/o.jpg	37.7698600000000013	-122.449719999999999	4
179	DOSA on Fillmore	dosa-on-fillmore-san-francisco-3	4	https://s3-media3.fl.yelpcdn.com/bphoto/CmpTsjFw9Cn7a3GZJikgcA/o.jpg	37.7853500000000011	-122.432839999999999	4
180	Urbann Turbann	urbann-turbann-berkeley-2	4	https://s3-media4.fl.yelpcdn.com/bphoto/zwIELFvUgMVugDmM7QJmOw/o.jpg	37.8752599999999973	-122.260490000000004	4
181	Fresh Brew Coffee	fresh-brew-coffee-san-francisco	5	https://s3-media4.fl.yelpcdn.com/bphoto/G0xDrpOQyXxrrKnQrYm7iQ/o.jpg	37.7900100000000023	-122.411770000000004	5
182	The Soapbox Cafe	the-soapbox-cafe-san-francisco	5	https://s3-media4.fl.yelpcdn.com/bphoto/KtW1YiQgU3B6X0HSLckdkg/o.jpg	37.7974815000000035	-122.418472300000005	5
183	Ty Sandwich	ty-sandwich-san-francisco	5	https://s3-media2.fl.yelpcdn.com/bphoto/etKeoTf4GttOx36N0lXWrA/o.jpg	37.720911000000001	-122.437477599999994	5
184	Saigon Sandwich	saigon-sandwich-san-francisco	5	https://s3-media3.fl.yelpcdn.com/bphoto/RQ0l4IBFa5mzU-VYPaAeig/o.jpg	37.7831519576567985	-122.417318022036994	5
185	Banh Mi Ba Le	banh-mi-ba-le-oakland	5	https://s3-media2.fl.yelpcdn.com/bphoto/nZiWVJcIKBvRK8jg_EKJqw/o.jpg	37.7860599999999991	-122.241010000000003	5
186	Bunny	bunny-pacifica	5	https://s3-media4.fl.yelpcdn.com/bphoto/eY8rTppiMqtMp-v9A6muaw/o.jpg	37.6355700000000013	-122.491829999999993	5
187	Phnom Penh House	phnom-penh-house-oakland-2	5	https://s3-media4.fl.yelpcdn.com/bphoto/Wb12RzcZAszwHQoS-7dzVg/o.jpg	37.798527	-122.269144999999995	5
188	Monster Pho	monster-pho-oakland	4	https://s3-media4.fl.yelpcdn.com/bphoto/WUJTaruQ5sVS6DeyXxGgkw/o.jpg	37.8270729999999986	-122.257444000000007	5
189	Hai Ky Mi Gia	hai-ky-mi-gia-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/0dx8AHeL2OYsp84xXLL-RA/o.jpg	37.784080000000003	-122.417950000000005	5
190	Dinosaurs	dinosaurs-san-francisco-4	4	https://s3-media2.fl.yelpcdn.com/bphoto/oX333wuMIT6PtZlDPiBzVQ/o.jpg	37.7644154700871013	-122.431834858528006	5
191	Branch Line	branch-line-emeryville-7	5	https://s3-media4.fl.yelpcdn.com/bphoto/259tve4soeoxcwtPO6xupA/o.jpg	37.8410767950909985	-122.290617576136	5
192	Mom's Bun Mi	moms-bun-mi-oakland	5	https://s3-media1.fl.yelpcdn.com/bphoto/awJwgvoj4TaC3Rt22IZjMw/o.jpg	37.7893394874011008	-122.245762148951997	5
193	Cordon Bleu	cordon-bleu-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/VEnKPAUCX1jp9ISZuJckiQ/o.jpg	37.7907202999999967	-122.420511099999999	5
194	Vien Huong Restaurant	vien-huong-restaurant-oakland	4	https://s3-media2.fl.yelpcdn.com/bphoto/N2d8M4bc07XxPf4uLmjdZw/o.jpg	37.7992399999999975	-122.272530000000003	5
195	Ly's Vietnamese  Cuisine	lys-vietnamese-cuisine-san-francisco	5	https://s3-media1.fl.yelpcdn.com/bphoto/TLlw9aF3gDXRQcUTC10CnQ/o.jpg	37.8002899000000028	-122.430629999999994	5
196	Thanh Long	thanh-long-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/8EcjZpIVAEavHKYkTR2fFA/o.jpg	37.7601700000000022	-122.50609	5
197	DragonEats	dragoneats-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/IrXcbnBs-LaoFxlk0N0iPg/o.jpg	37.7784199000000029	-122.422920000000005	5
198	Banh Mi Ba Le Vietnamese Sandwich Deli	banh-mi-ba-le-vietnamese-sandwich-deli-el-cerrito	4	https://s3-media2.fl.yelpcdn.com/bphoto/0rXHMx9NV9vgDNSk6yU0IQ/o.jpg	37.903876099999998	-122.303873499999995	5
199	Thai Nghiep Ky Mi Gia	thai-nghiep-ky-mi-gia-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/uePtFAIGkuMYxMufVYg97g/o.jpg	37.7539242833532001	-122.479033808170001	5
200	DragonEats	dragoneats-san-francisco-7	5	https://s3-media1.fl.yelpcdn.com/bphoto/ksc8vPlBtEiU_mjYznP5RA/o.jpg	37.7693700000000021	-122.450050000000005	5
201	Cam Huong Restaurant	cam-huong-restaurant-oakland	4	https://s3-media1.fl.yelpcdn.com/bphoto/O2mW186HGoP_kuZyoWGmjA/o.jpg	37.8002350000000007	-122.270553000000007	5
202	Yummy Yummy	yummy-yummy-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/iNtuo93WsV9t8dU3Njiwbw/o.jpg	37.7636800000000008	-122.468789999999998	5
203	DragonEats	dragoneats-san-francisco-3	4	https://s3-media1.fl.yelpcdn.com/bphoto/ASKzyLV1upferCnp1Echmw/o.jpg	37.7865639060767009	-122.395390766950001	5
204	MunchBoxx	munchboxx-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/SC_oouahLGQb5vEDyxM8wQ/o.jpg	37.7944219999999973	-122.403868000000003	5
205	Hoang Dat Coffee Shop	hoang-dat-coffee-shop-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/mIcETvgLQWcaeWoDCZCmUA/o.jpg	37.7862500000000026	-122.418570000000003	5
206	Cafe Bunn Mi	cafe-bunn-mi-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/fUSAPT7T-EOPLlXuxevPVA/o.jpg	37.782730100000002	-122.463691699999998	5
207	Pho Ga Huong Que Cafe	pho-ga-huong-que-cafe-oakland	4	https://s3-media2.fl.yelpcdn.com/bphoto/ABE5FD_ZlhH7E5Wjenb-3w/o.jpg	37.7937895999999967	-122.252511900000002	5
208	Vanessa's Bistro	vanessas-bistro-berkeley	4	https://s3-media2.fl.yelpcdn.com/bphoto/6UNfPbwHSqv1b8W1fByTYQ/o.jpg	37.8918060000000025	-122.282298999999995	5
209	Kim's Cafe & Sandwiches	kims-cafe-and-sandwiches-albany-2	4	https://s3-media2.fl.yelpcdn.com/bphoto/RAW9K_XJj3IQ1DxwowS2kQ/o.jpg	37.890900000000002	-122.292280000000005	5
210	Little Vietnam Cafe	little-vietnam-cafe-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/9njf5qvcwZ0HrfwmBAaERg/o.jpg	37.7826889999999977	-122.464566099999999	5
211	Jasmine Garden	jasmine-garden-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/8-aLidQXaYXCfBA0H2E1jw/o.jpg	37.7678320881979985	-122.4293711065	5
212	Pho King	pho-king-oakland	4	https://s3-media3.fl.yelpcdn.com/bphoto/J5d9BUQtJCyQ3pokTKV92Q/o.jpg	37.7946846999999977	-122.252408500000001	5
213	Chang Thai - Thai and Vietnamese Cuisines	chang-thai-thai-and-vietnamese-cuisines-san-pablo	5	https://s3-media3.fl.yelpcdn.com/bphoto/CtXq4xFYuaya_MkEKQOteQ/o.jpg	37.9588012999999975	-122.347152699999995	5
214	Pho 2000	pho-2000-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/L7A5sXpqWHfx-2KqSGD2TA/o.jpg	37.7838800000000035	-122.417869999999994	5
215	Huong Tra	huong-tra-richmond	4	https://s3-media4.fl.yelpcdn.com/bphoto/ChfRNaADa2I-qkW5FcBwFA/o.jpg	37.9345565159870972	-122.324991782951003	5
216	Freshroll Vietnamese Rolls & Bowls	freshroll-vietnamese-rolls-and-bowls-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/viB2fPDrgWIEY_oZXMDg1Q/o.jpg	37.7839351290840995	-122.403370141983004	5
217	Dinosaurs Vietnamese Sandwiches	dinosaurs-vietnamese-sandwiches-san-francisco-3	4	https://s3-media3.fl.yelpcdn.com/bphoto/m5V3pm0SChrVKUJtQGCs0w/o.jpg	37.7315483093262003	-122.472511291504006	5
218	PPQ Dungeness Island	ppq-dungeness-island-san-francisco-2	4	https://s3-media2.fl.yelpcdn.com/bphoto/2-j9zyksMuwMEuhWZNyN5Q/o.jpg	37.7823300000000017	-122.484453999999999	5
219	Kim Huong	kim-huong-oakland	4	https://s3-media2.fl.yelpcdn.com/bphoto/Cok5eUOx7ejo8RuVR3_4DA/o.jpg	37.8003428999999969	-122.269454499999995	5
220	Tín Vietnamese Cuisine	tín-vietnamese-cuisine-san-francisco-3	4	https://s3-media4.fl.yelpcdn.com/bphoto/SWeY4D5_8R9Xsjt_qbCRYg/o.jpg	37.7807719999999989	-122.405680000000004	5
221	Sumiko	sumiko-alameda	5	https://s3-media2.fl.yelpcdn.com/bphoto/Y2RcRyzWAW2Bh1pULfoUWg/o.jpg	37.7747001999999981	-122.264892599999996	5
222	Mission Banh Mi	mission-banh-mi-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/9l-0MhSkud3wmXBZwmONOw/o.jpg	37.7616399999999999	-122.419455999999997	5
223	Golden Lotus Vegetarian Restaurant	golden-lotus-vegetarian-restaurant-oakland	4	https://s3-media1.fl.yelpcdn.com/bphoto/DDLDCxsLw_vRAaHmkp4TXA/o.jpg	37.8034800000000004	-122.270499999999998	5
224	Darren's Cafe	darrens-cafe-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/SR-9hZWkUWDS5s6UqUd-Kw/o.jpg	37.8075299999999999	-122.415869999999998	5
225	Pho Viet	pho-viet-san-rafael	4	https://s3-media2.fl.yelpcdn.com/bphoto/EUoC7_Imbgf_j-E5HLnP9g/o.jpg	37.9669030000000021	-122.514713	5
226	Sue's Kitchen	sues-kitchen-el-sobrante	5	https://s3-media4.fl.yelpcdn.com/bphoto/DsvSgk1O0J429tMiCaEBFA/o.jpg	37.9783516000000034	-122.294639599999996	6
227	Rooster & Rice	rooster-and-rice-san-francisco-4	5	https://s3-media3.fl.yelpcdn.com/bphoto/I3KtXLlVpmq_Ugcv-PHj6Q/o.jpg	37.7978400000000008	-122.435929999999999	6
228	Ben Thai Cafe	ben-thai-cafe-san-francisco	5	https://s3-media2.fl.yelpcdn.com/bphoto/BdYusRr5S4MEop5_N_46XQ/o.jpg	37.7892399999999995	-122.420649999999995	6
229	Thai Idea Vegetarian	thai-idea-vegetarian-san-francisco-2	5	https://s3-media3.fl.yelpcdn.com/bphoto/WxPBP70WV8ZAUbBG3AWn1g/o.jpg	37.7834938000000022	-122.419057499999994	6
230	Chai Thai Noodles	chai-thai-noodles-hayward	5	https://s3-media3.fl.yelpcdn.com/bphoto/Tc7kCgHM1z_wvIODSpjgRg/o.jpg	37.6839704092226029	-122.098937415807001	6
231	Thai Aroi-Dee	thai-aroi-dee-san-rafael	5	https://s3-media3.fl.yelpcdn.com/bphoto/yCWHAnHYuvwXXi9ek1pmiA/o.jpg	37.9738883999999999	-122.534179699999996	6
232	Vientian Café	vientian-café-oakland-2	4	https://s3-media2.fl.yelpcdn.com/bphoto/BDn-t1i1K_g0oPWG1kuYxA/o.jpg	37.7860399999999998	-122.205860000000001	6
233	Chai Thai Noodles	chai-thai-noodles-oakland-2	4	https://s3-media3.fl.yelpcdn.com/bphoto/xaL1DyV9x-0xs0veQ6PxKQ/o.jpg	37.7949589999999986	-122.253371999999999	6
234	Lers Ros Thai	lers-ros-thai-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/FRXmi9KWDNKAjdO6hfiDsg/o.jpg	37.7848781000000002	-122.417672999999994	6
235	Charm Thai Eatery	charm-thai-eatery-san-mateo-2	4	https://s3-media1.fl.yelpcdn.com/bphoto/ukH8bVF0R72ynpvfGtZ0Qg/o.jpg	37.5538205601560975	-122.316233887224996	6
236	Baan Thai Cuisine	baan-thai-cuisine-san-anselmo	5	https://s3-media4.fl.yelpcdn.com/bphoto/vmgjXavbsdmrwu129zmaYQ/o.jpg	37.9764595999999983	-122.563429099999993	6
237	Old Weang Ping	old-weang-ping-oakland	4	https://s3-media1.fl.yelpcdn.com/bphoto/FUgxSxMgthIbB3aPqghKRg/o.jpg	37.7746847000000017	-122.181115599999998	6
238	R'noh Thai	rnoh-thai-larkspur	4	https://s3-media4.fl.yelpcdn.com/bphoto/7lV_g6sXzxgRi7VoDG4_tw/o.jpg	37.9468400000000017	-122.545739999999995	6
239	Farmhouse Kitchen Thai Cuisine	farmhouse-kitchen-thai-cuisine-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/c7ed05m9lC2EmA3Aruue7A/o.jpg	37.7602179000000007	-122.411074900000003	6
240	Kitchen Story	kitchen-story-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/f8Q9kkvApHfKyX4dcdeTEA/o.jpg	37.7643545000000032	-122.430867599999999	6
241	Blackwood	blackwood-san-francisco-3	4	https://s3-media1.fl.yelpcdn.com/bphoto/GptSx4aG41dvCXYZeNJZDg/o.jpg	37.8005909999999972	-122.438832000000005	6
242	Thai Cottage Restaurant	thai-cottage-restaurant-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/5KAtR8ZnQ-Ic-HppTfPpnA/o.jpg	37.7603000000000009	-122.505539999999996	6
243	Blue Bay Thai Cuisine	blue-bay-thai-cuisine-san-pablo	4	https://s3-media3.fl.yelpcdn.com/bphoto/dtOIOyW0nZDv_1ZNrZ8RsQ/o.jpg	37.955593109130902	-122.33602142334	6
244	Sabuy Sabuy II	sabuy-sabuy-ii-berkeley	4	https://s3-media2.fl.yelpcdn.com/bphoto/mk20TxBaHKeGahAazWMlLg/o.jpg	37.8811499999999981	-122.295649999999995	6
245	Thai Time Restaurant	thai-time-restaurant-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/w2XiWc_qPiOfdMbyyJhXCA/o.jpg	37.7824737999999982	-122.466703999999993	6
246	Thailand Restaurant	thailand-restaurant-mill-valley	4	https://s3-media1.fl.yelpcdn.com/bphoto/YW-QEebz01nc5-qpY07wmQ/o.jpg	37.9022030000000001	-122.525908000000001	6
247	Yukol Place Thai Cuisine	yukol-place-thai-cuisine-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/ETbziGwKCaias8NcXDlHgg/o.jpg	37.7994100000000017	-122.440640000000002	6
248	Tamarind Hall	tamarind-hall-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/PPi-oQdTwwgMjFWzBxyfXA/o.jpg	37.7986815225029034	-122.407130934297996	6
249	Souk Savanh Restaurant	souk-savanh-restaurant-oakland	4	https://s3-media3.fl.yelpcdn.com/bphoto/TZ9rvW3sdaoaLj_HGiJeOw/o.jpg	37.7860293000000027	-122.240598300000002	6
250	Manora's Thai Cuisine	manoras-thai-cuisine-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/MsEERZe0dhCcOTejBoQm6Q/o.jpg	37.7708399999999997	-122.415279999999996	6
251	Regent Thai Restaurant	regent-thai-restaurant-san-francisco-2	4	https://s3-media3.fl.yelpcdn.com/bphoto/7-ktIpGspt49y416SdW4tA/o.jpg	37.743549999999999	-122.426929999999999	6
252	Marnee Thai	marnee-thai-san-francisco-2	4	https://s3-media1.fl.yelpcdn.com/bphoto/gdeX343-yYSVXbH1za3E-A/o.jpg	37.7651299999999992	-122.466710000000006	6
253	Bay Thai Cuisine	bay-thai-cuisine-san-rafael	4	https://s3-media4.fl.yelpcdn.com/bphoto/gZlw2H_d2HXfXn9GdeZd_w/o.jpg	37.9725400000000022	-122.524119999999996	6
254	Jitlada Thai Cuisine	jitlada-thai-cuisine-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/72_Zp3cPPcWRXNyQq9f3AA/o.jpg	37.7870100000000022	-122.429760000000002	6
255	Thoughts Style Cuisine Showroom	thoughts-style-cuisine-showroom-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/cqbiFujpixkelEs060Un4g/o.jpg	37.7772199999999998	-122.412509999999997	6
256	Jasmine Blossom Thai Cuisine	jasmine-blossom-thai-cuisine-emeryville	4	https://s3-media3.fl.yelpcdn.com/bphoto/ZEPci0PUym3iXmLIoAB8oA/o.jpg	37.8471120234097995	-122.291524026074001	6
257	Thai Smile Cuisine	thai-smile-cuisine-san-rafael	4	https://s3-media3.fl.yelpcdn.com/bphoto/Rg6aDlg2b-OEC_LWA4_rNA/o.jpg	37.9723600000000019	-122.520189999999999	6
258	Chang Thai - Thai and Vietnamese Cuisines	chang-thai-thai-and-vietnamese-cuisines-san-pablo	5	https://s3-media3.fl.yelpcdn.com/bphoto/CtXq4xFYuaya_MkEKQOteQ/o.jpg	37.9588012999999975	-122.347152699999995	6
259	Soi 4 Bangkok Eatery	soi-4-bangkok-eatery-oakland	4	https://s3-media2.fl.yelpcdn.com/bphoto/ZE48jwpUpSQGnQ8GGxbdag/o.jpg	37.8406074999999973	-122.251494899999997	6
260	Atcha Thai Bistro	atcha-thai-bistro-el-cerrito-2	5	https://s3-media2.fl.yelpcdn.com/bphoto/1EXYD5u_k-wcn-jwYrrIog/o.jpg	37.9109838049956025	-122.307769077805006	6
261	Pagan Restaurant	pagan-restaurant-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/YEVNu7jTySvAsUsFVKU6JQ/o.jpg	37.7814752999999968	-122.493240099999994	6
262	Ninna Restaurant	ninna-restaurant-oakland	4	https://s3-media4.fl.yelpcdn.com/bphoto/Dbmg-VNavUXzTgHNIzt8uw/o.jpg	37.8260548000000014	-122.2526194	6
263	Imm Thai Street Food	imm-thai-street-food-berkeley	4	https://s3-media2.fl.yelpcdn.com/bphoto/8jxYvjInv0CGO9-vYFy3fg/o.jpg	37.8717200000000034	-122.269019999999998	6
264	Champa Garden	champa-garden-san-francisco-2	4	https://s3-media4.fl.yelpcdn.com/bphoto/2zN6E7cYJ7BgrHZ9fEUcaQ/o.jpg	37.7250728797322026	-122.460025101900001	6
265	Basil Thai Restaurant & Bar	basil-thai-restaurant-and-bar-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/ywhtbFLbV1aYdPNXVkuKXg/o.jpg	37.7753999999999976	-122.409270000000006	6
266	Infinite Thai Eatery	infinite-thai-eatery-oakland	4	https://s3-media1.fl.yelpcdn.com/bphoto/BVguzkQTUwRcP-O-aGiocg/o.jpg	37.8292312999999965	-122.248977699999998	6
267	Tycoon Thai Restaurant	tycoon-thai-restaurant-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/VmsxcgCGwhGcEl5CAOK7AA/o.jpg	37.7856385135600021	-122.415149049806999	6
268	Banana Leaf Thai Cuisine	banana-leaf-thai-cuisine-el-cerrito-2	5	https://s3-media3.fl.yelpcdn.com/bphoto/4G5SVaNAuR16t6ibfL7rqg/o.jpg	37.9294460999999998	-122.321097300000005	6
269	Sticky Rice Cafe	sticky-rice-cafe-oakland	4	https://s3-media1.fl.yelpcdn.com/bphoto/0SzzjNPeWHtVMxOV9ijnGQ/o.jpg	37.7798599999999993	-122.229500000000002	6
270	Marnee Thai	marnee-thai-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/RA1KBue8kevZ74WcHg9p1g/o.jpg	37.7631099999999975	-122.481800000000007	6
271	Wally's Cafe	wallys-cafe-emeryville	5	https://s3-media3.fl.yelpcdn.com/bphoto/y3VuOvTfCv-PWZzQwrr2bA/o.jpg	37.8301438000000019	-122.279408000000004	7
272	Samiramis Imports	samiramis-imports-san-francisco-2	5	https://s3-media1.fl.yelpcdn.com/bphoto/F3OeRnLekRrv22LyM8EOLA/o.jpg	37.749645000000001	-122.418340000000001	7
273	Kitchen Istanbul	kitchen-istanbul-san-francisco	5	https://s3-media4.fl.yelpcdn.com/bphoto/GCPDzryQgDMYBWgLQjbGsg/o.jpg	37.7828843958139018	-122.463225816122005	7
274	Taste In Mediterranean Food	taste-in-mediterranean-food-burlingame-2	5	https://s3-media3.fl.yelpcdn.com/bphoto/ZH-D7nx6Isx2nozW-W58wg/o.jpg	37.5863422999999983	-122.364384299999998	7
275	Ba-Bite	ba-bite-oakland	5	https://s3-media2.fl.yelpcdn.com/bphoto/BdmokecWOmgPsZDedC0oww/o.jpg	37.8250884999999997	-122.254363999999995	7
276	Kabul Afghan Cuisine	kabul-afghan-cuisine-san-carlos	5	https://s3-media3.fl.yelpcdn.com/bphoto/9mjufdoHUfzNzD1LGbpIug/o.jpg	37.5121940000000009	-122.266480999999999	7
277	Yemen Kitchen	yemen-kitchen-san-francisco	5	https://s3-media4.fl.yelpcdn.com/bphoto/WHbRPf4XX-0JzIC0T1BuYg/o.jpg	37.7833448000000018	-122.412643700000004	7
278	Q's Halal Chicken	qs-halal-chicken-alameda	5	https://s3-media3.fl.yelpcdn.com/bphoto/sYtZ-pABfMcwcfDxAp29Ow/o.jpg	37.7643500000000003	-122.243949999999998	7
279	De Afghanan Kabob House	de-afghanan-kabob-house-san-francisco-2	5	https://s3-media2.fl.yelpcdn.com/bphoto/VYrlbqDborHYIC2TrcAfDQ/o.jpg	37.7857699999999994	-122.420359000000005	7
280	Tuba Authentic Turkish Restaurant	tuba-authentic-turkish-restaurant-san-francisco	5	https://s3-media2.fl.yelpcdn.com/bphoto/5Wwf7SvMSDEzQZ1e9GSkyQ/o.jpg	37.754891200000003	-122.422889499999997	7
281	Kamdesh	kamdesh-oakland-2	5	https://s3-media3.fl.yelpcdn.com/bphoto/PJ3AHmtoj5b-ILxQDleGXw/o.jpg	37.8034578999999979	-122.268280799999999	7
282	Lavash	lavash-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/IrEgnCri8Kpje6jMsSk2gg/o.jpg	37.7640200000000021	-122.463369999999998	7
283	Reem's	reems-san-francisco	5	https://s3-media2.fl.yelpcdn.com/bphoto/caqDulQt1uXvFw7FCBi4-w/o.jpg	37.7572199999999967	-122.418989999999994	7
284	Shami Restaurant & Hookah Lounge	shami-restaurant-and-hookah-lounge-san-leandro	5	https://s3-media3.fl.yelpcdn.com/bphoto/NhLrSbMTyWhogSALRqRnfg/o.jpg	37.6940700000000035	-122.112080000000006	7
285	Mid East Market	mid-east-market-san-bruno	5	https://s3-media2.fl.yelpcdn.com/bphoto/yGRR943rJLSH-E3F6jHruw/o.jpg	37.6150599999999997	-122.405619999999999	7
286	Old Jerusalem Restaurant	old-jerusalem-restaurant-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/etcQFRGEb229LsE8ukZlxg/o.jpg	37.7494333410663003	-122.418358325957996	7
287	Palmyra	palmyra-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/GH81nzFSkrGYtGgm7_zZjQ/o.jpg	37.7718509999999981	-122.433937	7
288	Truly Mediterranean	truly-mediterranean-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/DzGNj0nvFlLw7YzXH6YGww/o.jpg	37.7647859386295011	-122.422329609179002	7
289	Oasis Grill	oasis-grill-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/Sg5cz9hi_p6G22TFja2xRA/o.jpg	37.7944464239892994	-122.396736520868004	7
290	La Mediterranee	la-mediterranee-san-francisco-8	4	https://s3-media2.fl.yelpcdn.com/bphoto/yPEtwC3g87-gOjcaYKZixw/o.jpg	37.7900665000000018	-122.433878300000003	7
291	Adam's Mediterranean Grill & Café	adams-mediterranean-grill-and-café-oakland-4	5	https://s3-media3.fl.yelpcdn.com/bphoto/uBJmr_Wnod1fQ1oZp3Jb1Q/o.jpg	37.8045199000000025	-122.269099999999995	7
292	Kababbq Grille & Cafe	kababbq-grille-and-cafe-san-rafael	4	https://s3-media3.fl.yelpcdn.com/bphoto/9nZZ63aS_pbg3iTjDhegxg/o.jpg	37.9657860000000014	-122.515190599999997	7
293	Jannah	jannah-san-francisco-3	4	https://s3-media1.fl.yelpcdn.com/bphoto/zsHfuiAe8CLNvsNKVDkFkQ/o.jpg	37.7757457000000016	-122.445754800000003	7
294	Bursa	bursa-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/qxMBBAEKCJyqGPj6ckHrIg/o.jpg	37.7403600000000026	-122.466740000000001	7
295	Zaytoon Mediterranean Wraps	zaytoon-mediterranean-wraps-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/oq7wngr40SysXd2OrweZWg/o.jpg	37.7546800000000005	-122.421199999999999	7
296	El Mansour	el-mansour-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/Mi2PQAbDyqQNjiLSGVeRxQ/o.jpg	37.7816199999999967	-122.492755000000002	7
297	Cafe Zitouna	cafe-zitouna-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/qj6PH2XcOkpOJnEZ860h9w/o.jpg	37.7874600000000029	-122.420289999999994	7
298	Kobani Mediterranian Grill	kobani-mediterranian-grill-san-francisco	5	https://s3-media1.fl.yelpcdn.com/bphoto/utrtvAU2mROQAXFfzMJMuw/o.jpg	37.7997756637088003	-122.440967508932005	7
299	Mazzat Bistro	mazzat-bistro-san-bruno-2	4	https://s3-media3.fl.yelpcdn.com/bphoto/6yBRpRzHqIltLcL6bDSJCg/o.jpg	37.6264978999999968	-122.424924000000004	7
300	Pera	pera-san-francisco	4	https://s3-media3.fl.yelpcdn.com/bphoto/olYk5T1Yot_9F82EmRoXQA/o.jpg	37.7624840000000006	-122.397088999999994	7
301	La Mediterranee	la-mediterranee-san-francisco-7	4	https://s3-media2.fl.yelpcdn.com/bphoto/Md10H06eVB2GPiadrus1rw/o.jpg	37.7645069776939977	-122.433297442680001	7
302	Bacheesos	bacheesos-oakland	4	https://s3-media1.fl.yelpcdn.com/bphoto/ZStEW-3nZ6F6_en8JTpuYw/o.jpg	37.8099047404802988	-122.259215153753999	7
303	Sahaara	sahaara-burlingame-2	4	https://s3-media3.fl.yelpcdn.com/bphoto/fbNZ58UgRjGXFhxLzfRYpw/o.jpg	37.5871319000000028	-122.364097900000004	7
304	Arabian Nights Restaurant	arabian-nights-restaurant-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/OWjR4pa_zbI6GL5wNb1Bmg/o.jpg	37.7595150000000004	-122.418781999999993	7
305	A La Turca Restaurant	a-la-turca-restaurant-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/ruBsSoTNiSQErLjBjY4ioA/o.jpg	37.7859699999999989	-122.417590000000004	7
306	Sababa	sababa-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/RZr5dK5IUMxKl-DUEp5zwg/o.jpg	37.7911832391355986	-122.404289804398999	7
307	Blue Front Cafe	blue-front-cafe-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/o1s8wUwZqpO97u1MxGN6Tw/o.jpg	37.7702499999999972	-122.446070000000006	7
308	Aicha	aicha-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/LVHqgDZTlThSEey0oyCEEA/o.jpg	37.7889169999999979	-122.420445999999998	7
309	Maykadeh	maykadeh-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/U5g9uE_YjVbYMP9IQ6k7fw/o.jpg	37.8000200000000035	-122.407139999999998	7
310	Razan's Organic Kitchen	razans-organic-kitchen-berkeley-2	4	https://s3-media3.fl.yelpcdn.com/bphoto/xeWzwfoQFfnXNZdfIrIJXQ/o.jpg	37.868731299417	-122.266883755500004	7
311	Sunrise Deli	sunrise-deli-san-francisco-6	4	https://s3-media4.fl.yelpcdn.com/bphoto/iaKST_-JfJK9pZu_bZn6Bg/o.jpg	37.7631500000000031	-122.48075	7
312	North Beach Gyros	north-beach-gyros-san-francisco	4	https://s3-media1.fl.yelpcdn.com/bphoto/oHlFR8wibGwJWx_LTevgiA/o.jpg	37.800142000000001	-122.411015000000006	7
313	Twilight Cafe	twilight-cafe-san-francisco	4	https://s3-media2.fl.yelpcdn.com/bphoto/68N13Oe6yu0i8bcdNBNwGA/o.jpg	37.7757004747203027	-122.455088515344002	7
314	Ali Baba	ali-baba-south-san-francisco-2	4	https://s3-media3.fl.yelpcdn.com/bphoto/tZRqFQGPrERnwSIWoZiLfw/o.jpg	37.6470699999999994	-122.409980000000004	7
315	Falafel Hut	falafel-hut-san-rafael	4	https://s3-media3.fl.yelpcdn.com/bphoto/loxfmy6g8qD0lwAHcGP7iQ/o.jpg	37.9730699999999999	-122.528559999999999	7
316	Ramen Underground	ramen-underground-san-francisco-4	3	https://s3-media3.fl.yelpcdn.com/bphoto/zCqRv4lAxzMXKQGuKvhxIQ/o.jpg	37.7853348000000011	-122.429179099999999	1
317	Pokihub	pokihub-san-francisco-2	5	https://s3-media3.fl.yelpcdn.com/bphoto/jV2LLkKvvf7KC1HcjHffTQ/o.jpg	37.7235334011631025	-122.453693933546006	1
318	Pokihub	pokihub-san-francisco-2	5	https://s3-media3.fl.yelpcdn.com/bphoto/jV2LLkKvvf7KC1HcjHffTQ/o.jpg	37.7235334011631025	-122.453693933546006	1
319	Thep Phanom Thai Restaurant	thep-phanom-thai-restaurant-san-francisco-2	4	https://s3-media3.fl.yelpcdn.com/bphoto/BDOItfvBrrxP5G_atLeHlA/o.jpg	37.7713922000000011	-122.430412700000005	6
320	Thai Cottage Restaurant	thai-cottage-restaurant-san-francisco	4	https://s3-media4.fl.yelpcdn.com/bphoto/5KAtR8ZnQ-Ic-HppTfPpnA/o.jpg	37.7603000000000009	-122.505539999999996	6
\.


--
-- Name: restaurants_restaurant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('restaurants_restaurant_id_seq', 320, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY users (user_id, username, password, fname, lname, fav_cuisine, last_login, membership) FROM stdin;
5	jsmith	123	John	Smith	Vietnamese	2016-11-15 01:42:58.677247	2016-11-15 01:42:58.677241
7	tshawn	123	Thomas	Shawn	Japanese	2016-11-15 01:42:58.677247	2016-11-15 01:42:58.677241
8	bdraco	123	Bob	Draco	Indian	2016-11-15 01:42:58.677247	2016-11-15 01:42:58.677241
10	lkim	123	Lyn	Kim	Chinese	2016-11-15 01:42:58.677247	2016-11-15 01:42:58.677241
4	awalker	123	Allen	Walker	Indian	2016-11-15 22:39:53.636447	2016-11-15 01:42:58.677241
6	acooper	123	Alex	Cooper	Middle Eastern	2016-11-16 20:20:59.745241	2016-11-15 01:42:58.677241
9	sgregor	123	Sydney	Gregor	Korean	2016-11-16 20:21:34.296911	2016-11-15 01:42:58.677241
2	cbob	123	Chris	Bob	Chinese	2016-11-16 22:52:56.013667	2016-11-15 01:42:58.677241
1	jhacks	123	Jane	Hacks	Japanese	2016-11-21 20:25:26.1425	2016-11-15 01:42:58.677241
3	ksmith	123	Kay	Smith	Korean	2016-11-21 22:31:37.464296	2016-11-15 01:42:58.677241
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('users_user_id_seq', 11, true);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (comment_id);


--
-- Name: cuisine_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY cuisine
    ADD CONSTRAINT cuisine_pkey PRIMARY KEY (cuisine_id);


--
-- Name: favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: popularity_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY popularity
    ADD CONSTRAINT popularity_pkey PRIMARY KEY (id);


--
-- Name: ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (rating_id);


--
-- Name: restaurants_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY restaurants
    ADD CONSTRAINT restaurants_pkey PRIMARY KEY (restaurant_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users_username_key; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: comments_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id);


--
-- Name: comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: favorites_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id);


--
-- Name: favorites_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY favorites
    ADD CONSTRAINT favorites_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: popularity_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY popularity
    ADD CONSTRAINT popularity_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES comments(comment_id);


--
-- Name: popularity_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY popularity
    ADD CONSTRAINT popularity_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id);


--
-- Name: popularity_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY popularity
    ADD CONSTRAINT popularity_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: ratings_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id);


--
-- Name: ratings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: restaurants_cuisine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY restaurants
    ADD CONSTRAINT restaurants_cuisine_id_fkey FOREIGN KEY (cuisine_id) REFERENCES cuisine(cuisine_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

