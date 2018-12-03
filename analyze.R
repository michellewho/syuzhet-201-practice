#install.packages("syuzhet")
#devtools::install_github("mjockers/syuzhet")
library(syuzhet)
library(dplyr)
library(stringr)
library(tidytext)
library(tidyr)
library(ggplot2)

### Example Introduction ###

# unique sentences
my_example_text <- "I begin this story with a neutral statement.  
  Basically this is a very silly test.  
  You are testing the Syuzhet package using short, inane sentences.  
  I am actually very happy today. 
  I have finally finished writing this package.  
  Tomorrow I will be very sad. 
  I won't have anything left to do. 
  I might get angry and decide to do something horrible.  
  I might destroy the entire package and start from scratch.  
  Then again, I might find it satisfying to have completed my first R package. 
  Honestly this use of the Fourier transformation is really quite elegant.  
  You might even say it's beautiful!"

# get_sentences: new character vector for each tokenized sentence
s_v <- get_sentences(my_example_text)

# get sentiment of text
s_v_sentiment <- get_sentiment(s_v)

# plot values in graph
plot(
  s_v_sentiment, 
  type="l", 
  main="Example Plot Trajectory", 
  xlab = "Sentence", 
  ylab= "Emotional Valence"
)

plot(
  s_v_sentiment, 
  type="h", 
  main="Example Plot Trajectory", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence"
)


### Calculating Sentiment of Tweets ###

# Use the get_sentiments() function to get your dictionary of positive
# and negative words. Use the lexicon which categorizes words into
# positive and negative.

# afinn_sentiments <- get_sentiments("afinn")
# nrc_sentiments <- get_sentiments("nrc")

bing_sentiments <- get_sentiments("bing")



##### DATA ANALYSIS + WRANGLING #####
# Read tweets data in 
tweets <- read.csv("tweets.csv", stringsAsFactors = FALSE)
head(tweets)

# Seperate Obama and Trump's tweets into different data frames
obama_tweets <- tweets %>% filter(person == "Barack Obama")
trump_tweets <- tweets %>% filter(person == "Donald Trump")

# Parse the tweets into individual sentences
obama <- get_sentences(obama_tweets$tweets)
trump <- get_sentences(trump_tweets$tweets)

# Obtain the sentiments for each sentence
obama_sentiment <- get_sentiment(obama)
trump_sentiment <- get_sentiment(trump)

# Calculate total sentiment for each person
obama_sentiment <- sum(obama_sentiment) # 11.95
trump_sentiment <- sum(trump_sentiment) # 10.55






