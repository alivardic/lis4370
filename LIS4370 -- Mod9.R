library(readr)
library(ggplot2)
library(tidyverse)
sentiment <- read_csv("sentiment_counts.csv")
trump <- read_csv("trump_tweets.csv")

sentiment <- sentiment %>%
  mutate(total = Android + iPhone) %>%
  filter(sentiment != "none")

# TRUMP SENTIMENT COUNTS
ggplot(sentiment, aes(sentiment, total)) +
  geom_bar(stat = "identity") +
  theme_light() +
  labs(x = "Sentiment", y = "Frequency", 
       title = "Sentiments Expressed by Trump over Twitter (2009 - 2018)")

#TRUMP TIMESERIES ANALYSIS -- linechart
ggplot(trump, aes(created_at, favorite_count)) +
  geom_line(linewidth = 0.5) +
  theme_light() +
  geom_smooth(method = "lm", color = "tomato") +
  labs(x = "Date", y = "Favorites", title = "Trump Tweets Favorite Frequency over the Years (2009 - 2018)")
  
#TRUMP TIMESERIES ANALYSIS -- Boxplot
ggplot(trump, aes(as.factor(year(created_at)), favorite_count)) +
  geom_boxplot() +
  theme_light()+
  labs(x = "Year", y ="Favorites", title = "Fluctuations  of Trump's Tweets Favorites over the Years (2009 - 2018)")


