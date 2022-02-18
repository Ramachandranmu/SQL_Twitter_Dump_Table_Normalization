/* Query 1 How many tweets are there in total */
SELECT COUNT(*) AS TWEETS_COUNT
FROM TWEET;

/* Query 2 For every language the number of tweets in that language */
SELECT LOCALE_SETTINGS.user_lang, COUNT(TWEET.tweet_id) AS tweets_count_per_language FROM LOCALE_SETTINGS
INNER JOIN TWEET
ON LOCALE_SETTINGS.user_id = TWEET.user_id
GROUP BY LOCALE_SETTINGS.user_lang;

/* Query 3 fraction of total tweets that have that language setting, as well as the fraction of users that have that language settings */

/*
SELECT COUNT(TWEET.tweet_id) FROM TWEET
JOIN LOCALE_SETTINGS ON TWEET.user_id = LOCALE_SETTINGS.user_id
GROUP BY LOCALE_SETTINGS.user_lang;

SELECT COUNT(user_id) FROM LOCALE_SETTINGS 
GROUP BY user_lang;

SELECT user_lang, 

WHERE user_lang IN(SELECT DISTINCT user_lang FROM LOCALE_SETTINGS)
*/


/* Query 4 Fraction of tweets that are retweets */
SELECT
CAST((SELECT COUNT(retweet_of_tweet_id) FROM TWEET 
WHERE retweet_of_tweet_id IS NOT NULL) AS float)/CAST((SELECT COUNT(*) FROM TWEET) AS float) AS fraction_of_tweets_that_are_retweets;

/* Query 5 the average number of retweets per tweet */
SELECT AVG(retweet_count) AS average_retweets_per_tweet FROM TWEET
WHERE retweet_of_tweet_id IS NOT NULL;

/* Query 6 fraction of tweets that are never retweeted */
SELECT
(1-CAST((SELECT COUNT(retweet_of_tweet_id) FROM TWEET 
WHERE retweet_of_tweet_id IS NOT NULL) AS float)/CAST((SELECT COUNT(*) FROM TWEET) AS float)) AS fraction_of_tweets_not_retweeted;

/* Query 7 fraction of tweets that are retweeted fewer times than the average number of retweets */

SELECT
CAST((SELECT COUNT(retweet_of_tweet_id) FROM TWEET 
WHERE retweet_count < (SELECT AVG(retweet_count) AS average_retweets_per_tweet FROM TWEET
WHERE retweet_of_tweet_id IS NOT NULL) AND retweet_of_tweet_id IS NOT NULL) AS float)/CAST((SELECT COUNT(*) FROM TWEET) AS float) AS fraction_of_fewer_retweets;

/* Query 8 Number of distinct hashtags found in the tweet table */

SELECT count(*) AS COUNT_DISTINCT_HASTAGS FROM
((select hashtag1 AS distinct_hashtag FROM HASHTAG WHERE hashtag1 IS NOT NULL)
UNION
(select hashtag2 AS distinct_hashtag FROM HASHTAG WHERE hashtag2 IS NOT NULL)  
UNION
(select hashtag3 AS distinct_hashtag FROM HASHTAG WHERE hashtag3 IS NOT NULL)  
UNION
(SELECT hashtag4 AS distinct_hashtag FROM HASHTAG WHERE hashtag4 IS NOT NULL)  
UNION
(SELECT hashtag5 AS distinct_hashtag FROM HASHTAG WHERE hashtag5 IS NOT NULL)  
UNION 
(SELECT hashtag6 AS distinct_hashtag FROM HASHTAG WHERE hashtag6 IS NOT NULL))count_distinct;


/* Query 9 top ten most popular hashtags by number of usages */
SELECT popular_hashtag, count(*) AS hashtag_count
FROM (
(select hashtag1 AS popular_hashtag FROM HASHTAG WHERE hashtag1 IS NOT NULL)
UNION ALL
(select hashtag2 AS popular_hashtag FROM HASHTAG WHERE hashtag2 IS NOT NULL)  
UNION ALL
(select hashtag3 AS popular_hashtag FROM HASHTAG WHERE hashtag3 IS NOT NULL)  
UNION ALL
(SELECT hashtag4 AS popular_hashtag FROM HASHTAG WHERE hashtag4 IS NOT NULL)  
UNION ALL
(SELECT hashtag5 AS popular_hashtag FROM HASHTAG WHERE hashtag5 IS NOT NULL)  
UNION ALL
(SELECT hashtag6 AS popular_hashtag FROM HASHTAG WHERE hashtag6 IS NOT NULL))hashtag_count_popular
GROUP BY popular_hashtag
ORDER BY hashtag_count DESC
LIMIT 10;

/* Query 10 For each language the top three most popular hashtags in that language */

/*
CREATE VIEW hashtag_view AS
SELECT TWEET.tweet_id, LOCALE_SETTINGS.user_lang, HASHTAG.hashtag1, HASHTAG.hashtag2, HASHTAG.hashtag3, HASHTAG.hashtag4, HASHTAG.hashtag5, HASHTAG.hashtag6
FROM TWEET
JOIN LOCALE_SETTINGS ON TWEET.user_id = LOCALE_SETTINGS.user_id
JOIN HASHTAG ON TWEET.tweet_id = HASHTAG.tweet_id; 

*/


/* Query 11 how many tweets that are neither replies nor replied to */
SELECT (
(SELECT COUNT(*) FROM TWEET)-
((SELECT COUNT(*) FROM REPLY JOIN TWEET ON REPLY.in_reply_to_status_id = TWEET.in_reply_to_status_id)+
(SELECT COUNT(*) FROM TWEET WHERE tweet_id in (SELECT in_reply_to_status_id FROM REPLY)))) AS tweets_not_replied;


/* Query 13 probability of two arbitary users having the same language setting */
SELECT (1/CAST((select count(distinct user_lang) from LOCALE_SETTINGS) AS FLOAT))*(1/CAST((select count(distinct user_lang) from LOCALE_SETTINGS) AS FLOAT)) AS probability_arbitary;




