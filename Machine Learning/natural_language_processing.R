# Natural Language Processing is concerned with the interactions between computers and human language, in particular how to program computers to process and analyze large amounts of natural language data.

#Install the necessary libraries
# We'll need the following libraries:
#     tm
#     twitteR
#     wordcloud
#     RColorBrewer
#     e1017
#     class

#Step 1: Import Libraries
library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)

#Step 2: Search for Topic on Twitter
#  First you need to connect by setting up your Authorization keys and tokens.
setup_twitter_oauth(consumer_key, consumer_secret, access_token=NULL, access_secret=NULL)


#We will search twitter for the term 'soccer'
soccer.tweets <- searchTwitter("soccer", n=2000, lang="en")
soccer.text <- sapply(soccer.tweets, function(x) x$getText())


#Step 3: Clean Text Data
soccer.text <- iconv(soccer.text, 'UTF-8', 'ASCII') # remove emoticons
soccer.corpus <- Corpus(VectorSource(soccer.text)) # create a corpus


#Step 4: Create a Document Term Matrix
term.doc.matrix <- TermDocumentMatrix(soccer.corpus,
                                      control = list(removePunctuation = TRUE,
                                                     stopwords = c("soccer","http", stopwords("english")),
                                                     removeNumbers = TRUE,tolower = TRUE))


# Step 5: Check out Matrix
head(term.doc.matrix)
term.doc.matrix <- as.matrix(term.doc.matrix)


#Step 6: Get Word Counts
word.freqs <- sort(rowSums(term.doc.matrix), decreasing=TRUE) 
dm <- data.frame(word=names(word.freqs), freq=word.freqs)


#Step 7: Create Word Cloud
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))




