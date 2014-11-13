
# make essay list of Corpus type
train.corpus  <- Corpus(VectorSource(essay.raw.data$train$essay))
test.corpus   <- Corpus(VectorSource(essay.raw.data$test$essay))
 
# TODO erase @-like words 

# to lower case

train.corpus  <- tm_map(train.corpus, content_transformer(tolower), lazy=TRUE)
test.corpus  <- tm_map(test.corpus, content_transformer(tolower), lazy=TRUE)

# remove stopwords
# TODO add more words like "it's" 

train.corpus  <- tm_map(train.corpus, removeWords, stopwords("en"), lazy=TRUE)
test.corpus  <- tm_map(test.corpus, removeWords, stopwords("en"), lazy=TRUE)

# remove punctuation

train.corpus  <- tm_map(train.corpus, removePunctuation, lazy=TRUE)
test.corpus  <- tm_map(test.corpus, removePunctuation, lazy=TRUE)

# remove numbers

train.corpus  <- tm_map(train.corpus, removeNumbers, lazy=TRUE)
test.corpus  <- tm_map(test.corpus, removeNumbers, lazy=TRUE)

# erase whitespaces

train.corpus  <- tm_map(train.corpus, stripWhitespace, lazy=TRUE) #dont work
test.corpus  <- tm_map(test.corpus, stripWhitespace, lazy=TRUE) # dont work

# TODO fix errors in words
# TODO check stemming algorythms. dont convert eaiser -> easy

train.corpus  <- tm_map(train.corpus, stemDocument, lazy=TRUE) # work strange
test.corpus  <- tm_map(test.corpus, stemDocument, lazy=TRUE) # work strange