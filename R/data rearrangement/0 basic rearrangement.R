source(paste0(getwd(), "/R/data rearrangement/_list stemming.R"))
source(paste0(getwd(), "/R/data rearrangement/_stop words removal.R"))

# make essay list of Corpus type
train.corpus  <- essay.raw.data$train$essay
#test.corpus   <- Corpus(VectorSource(essay.raw.data$test$essay))
 
# erase @-like words 

train.corpus <- mapply(gsub, "@\\w+","",train.corpus)

# remove punctuation

train.corpus <- mapply(gsub, "\\W+"," ",train.corpus)
#test.corpus  <- tm_map(test.corpus, removePunctuation, lazy=TRUE)

# to lower case

train.corpus <- mapply(tolower,train.corpus)
#test.corpus  <- tm_map(test.corpus, content_transformer(tolower), lazy=TRUE)

# remove stopwords
# TODO add more words like "it's" 
# FUCKIN TIME CONSUMING OPERATION 20m+. Better read from file 

train.corpus <- lapply(train.corpus, stopWordsRemove, stopwords("SMART"))

# stem words

train.corpus <- mapply(stemmingToBigStrings, train.corpus)

# remove numbers

#test.corpus  <- tm_map(test.corpus, removeNumbers, lazy=TRUE)

# erase whitespaces

train.corpus <- mapply(gsub, "\\s+"," ",train.corpus)
#test.corpus  <- tm_map(test.corpus, stripWhitespace, lazy = TRUE) # dont work

# TODO fix errors in words
# TODO check stemming algorythms