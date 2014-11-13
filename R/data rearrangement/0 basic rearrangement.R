
# make essay list of Corpus type
train.corpus  <- Corpus(VectorSource(essay.raw.data$train$essay))
test.corpus   <- Corpus(VectorSource(essay.raw.data$test$essay))
 
# TODO erase @-like words 

# to lower case

train.corpus  <- tm_map(train.corpus, tolower)
test.corpus  <- tm_map(test.corpus, tolower)

# remove stopwords
# TODO add more words like "it's" 

train.corpus  <- tm_map(train.corpus, removeWords, stopwords("en"))
test.corpus  <- tm_map(test.corpus, removeWords, stopwords("en"))

# remove punctuation

train.corpus  <- tm_map(train.corpus, removePunctuation)
test.corpus  <- tm_map(test.corpus, removePunctuation)

# remove numbers

train.corpus  <- tm_map(train.corpus, removeNumbers)
test.corpus  <- tm_map(test.corpus, removeNumbers)

# erase whitespaces

train.corpus  <- tm_map(train.corpus, stripWhitespace)
test.corpus  <- tm_map(test.corpus, stripWhitespace)