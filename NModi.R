
# Load Requried Packages
library("SnowballC")
library("tm")
library("twitteR")
library("syuzhet")
library("base64enc")
library(openssl)
# Authonitical keys
consumer_key <- '0ONfK6l5Njb9c8lR2C3JwfmR2'
consumer_secret <- 'q7jPSy1V6dsyngWsdiUEjHbiDMHvLNrf1s4CeOApKBrbxX1bBT'
access_token <- '956454756058386433-V1htvplhTd6pdLQqT5gKFHeHrnbrRIp'
access_secret <- '9wIFZRgBLaBMiYV2encjC3FDuMOBmHNyIwM0VJm6ltlZx'

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
tweets <- userTimeline("narendramodi", n=200)

n.tweet <- length(tweets)

tweets.df <- twListToDF(tweets) 

head(tweets.df)


tweets.df2 <- gsub("http.*","",tweets.df$text)

tweets.df2 <- gsub("https.*","",tweets.df2)

tweets.df2 <- gsub("#.*","",tweets.df2)

tweets.df2 <- gsub("@.*","",tweets.df2)

word.df <- as.vector(tweets.df2)

emotion.df <- get_nrc_sentiment(word.df)

emotion.df2 <- cbind(tweets.df2, emotion.df) 

head(emotion.df2)
sent.value <- get_sentiment(word.df)

most.positive <- word.df[sent.value == max(sent.value)]

most.positive
most.negative <- word.df[sent.value <= min(sent.value)] 
most.negative 

positive.tweets <- word.df[sent.value>0]
negative.tweets <- word.df[sent.value<0]
neutral.tweets <- word.df[sent.value==0]