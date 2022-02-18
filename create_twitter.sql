/* Creating table USER_TABLE */

CREATE TABLE USER_TABLE(user_id BIGINT, user_name character varying(255), user_screen_name character varying(255), PRIMARY KEY(user_id));

/* Creating table USER_PROFILE */

CREATE TABLE USER_PROFILE(user_id BIGINT, user_followers_count integer, user_friends_count integer, user_description varchar(255), user_status_count varchar(255), user_created_at timestamp with time zone, 
FOREIGN KEY (user_id) REFERENCES USER_TABLE(user_id), UNIQUE(user_id));

/* Creating table LOCALE_SETTINGS */

CREATE TABLE LOCALE_SETTINGS(user_id BIGINT, user_lang character varying(10), user_location character varying(255), user_utc_offset integer, user_time_zone character varying(127), FOREIGN KEY (user_id) REFERENCES USER_TABLE(user_id), UNIQUE(user_id));

/* Creating table REPLY */

CREATE TABLE REPLY(in_reply_to_status_id BIGINT, in_reply_to_screen_name varchar(255), in_reply_to_user_id BIGINT, PRIMARY KEY(in_reply_to_status_id));

/* Creating table TWEET */

CREATE TABLE TWEET(tweet_id BIGINT, text VARCHAR(255), user_id BIGINT, retweet_of_tweet_id BIGINT, retweet_count int, in_reply_to_status_id bigint, tweet_source varchar(255), created_at timestamp with time zone, PRIMARY KEY(tweet_id), FOREIGN KEY (in_reply_to_status_id) REFERENCES REPLY(in_reply_to_status_id), FOREIGN KEY (user_id) REFERENCES USER_TABLE(user_id));

/* Creating table HASHTAG */

CREATE TABLE HASHTAG(tweet_id BIGINT, hashtag1 varchar(144), hashtag2 varchar(144), hashtag3 varchar(144), hashtag4 varchar(144), hashtag5 varchar(144),
hashtag6 varchar(144), FOREIGN KEY(tweet_id) REFERENCES TWEET(tweet_id), UNIQUE(tweet_id));


