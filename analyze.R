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


### Example of Jane Austen's Books ###

# Use the get_sentiments() function to get your dictionary of positive
# and negative words. Use the lexicon which categorizes words into
# positive and negative.
bing_sentiments <- get_sentiments("bing")



##### DATA ANALYSIS + WRANGLING #####
# Read books data in 
books <- read.csv("austen_books.csv", stringsAsFactors = FALSE)
head(books)



# Map each word in the 'books' dataset to its dictionary-prescribed sentiment.
jane_austen_sentiment <- books %>%
  inner_join(bing_sentiments, by = "word")
head(jane_austen_sentiment)



# Instead of having each individual word, count the number of positive/negative
# words in each chapter.
jane_austen_sentiment <- jane_austen_sentiment %>%
  count(book, chapter, sentiment)



# A chapter's overarching feeling will be calculated by the number of positive
# words minus the number of negative words. Create a new column called 
# 'sentiment' with this value.
jane_austen_sentiment <- jane_austen_sentiment %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)




##### CREATE OUR VISUALIZATION #####
# Use ggplot to plot each chapter's sentiment by book.

ja_graph <- ggplot(jane_austen_sentiment, aes(chapter, sentiment, fill = book)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~book, ncol = 2, scales = "free_x")
ja_graph


