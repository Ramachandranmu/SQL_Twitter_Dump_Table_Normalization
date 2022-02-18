/* Copying Data from bad_giant_table into normalized sub tables */

INSERT INTO USER_TABLE(user_id,user_name,user_screen_name)
SELECT user_id,user_name,user_screen_name
FROM bad_giant_table
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO USER_PROFILE(user_id, user_followers_count, user_friends_count, user_description, user_status_count, user_created_at)
SELECT user_id, user_followers_count, user_friends_count, user_description, user_status_count, user_created_at
FROM bad_giant_table
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO LOCALE_SETTINGS(user_id, user_lang, user_location, user_utc_offset, user_time_zone)
SELECT user_id, user_lang, user_location, user_utc_offset, user_time_zone
FROM bad_giant_table
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO REPLY(in_reply_to_status_id,in_reply_to_screen_name,in_reply_to_user_id)
SELECT in_reply_to_status_id,in_reply_to_screen_name,in_reply_to_user_id 
FROM bad_giant_table
WHERE in_reply_to_status_id IS NOT NULL
ON CONFLICT (in_reply_to_status_id) DO NOTHING;

INSERT INTO TWEET(tweet_id,text,user_id,retweet_of_tweet_id,retweet_count,in_reply_to_status_id,tweet_source,created_at) 
SELECT tweet_id,text,user_id,retweet_of_tweet_id,retweet_count,in_reply_to_status_id,tweet_source,created_at
FROM bad_giant_table;

INSERT INTO HASHTAG(tweet_id, hashtag1, hashtag2, hashtag3, hashtag4, hashtag5, hashtag6)
SELECT tweet_id, hashtag1, hashtag2, hashtag3, hashtag4, hashtag5, hashtag6
FROM bad_giant_table
WHERE hashtag1 IS NOT NULL;














