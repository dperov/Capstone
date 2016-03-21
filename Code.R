install.packages("tm")
install.packages("wordcloud")
install.packages("ggplot2")
install.packages("R.utils")
library (R.utils)
library (tm)
library(wordcloud)
library(ggplot2)

countLines("Coursera-SwiftKey/final/en_US/en_US.blogs.txt")
countLines("Coursera-SwiftKey/final/en_US/en_US.news.txt")
countLines("Coursera-SwiftKey/final/en_US/en_US.twitter.txt")


theCorpus <- VCorpus(DirSource("Coursera-SwiftKey/final/en_US/", encoding = "UTF-8"), readerControl = list(reader = readPlain))

inspect(theCorpus)
theCorpus <- tm_map(theCorpus, stripWhitespace)

## Convert to lower case
theCorpus <- tm_map(theCorpus, content_transformer(tolower))

## Do not remove stop words (most common words in the language) for now.
## We theorize having them will enhance the predictive model.  We will test this when we actually develop our algorithm.
## theCorpus <- tm_map(theCorpus, removeWords, stopwords("english"))

## Prepare a list of profane words to remove from the corpus.
## Citation for list of profane words to remove:  http://www.frontgatemedia.com/new/wp-content/uploads/2014/03/Terms-to-Block.csv
profanity <- read.csv("profanity.csv", header = FASLE)
profwords <- as.vector(profanity)
bw2 <- as.vector(bw[4:726, 2])
bw3 <- gsub(',', '', bw2)
## Remove profanity
theCorpus <- tm_map(theCorpus, removeWords, profwords)

## Remove punctuation
theCorpus <- tm_map(theCorpus, removePunctuation)

## Remove numbers
theCorpus <- tm_map(theCorpus, removeNumbers)  