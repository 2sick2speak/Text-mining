source(paste0(getwd(), "/R/data rearrangement/_list stemming.R"))
source(paste0(getwd(), "/R/data rearrangement/_stop words removal.R"))

# make essay list of Corpus type
train.corpus  <- essay.raw.data$train$essay[1:100]
#test.corpus   <- Corpus(VectorSource(essay.raw.data$test$essay))
 
# erase @-like words 

train.corpus <- mapply(gsub, "@\\w+","",train.corpus)

# remove punctuation

train.corpus <- mapply(gsub, "\\W+"," ",train.corpus)
#test.corpus  <- tm_map(test.corpus, removePunctuation, lazy=TRUE)

# remove numbers

train.corpus <- mapply(gsub, "\\d+"," ",train.corpus)
#test.corpus  <- tm_map(test.corpus, removeNumbers, lazy=TRUE)

# to lower case

train.corpus <- mapply(tolower,train.corpus)
#test.corpus  <- tm_map(test.corpus, content_transformer(tolower), lazy=TRUE)

# remove stopwords
# FUCKIN TIME CONSUMING OPERATION 20m+ for 8k texts. Better read from file 

train.corpus <- lapply(train.corpus, stopWordsRemove, stopwords("SMART"))

# stem words

train.corpus <- mapply(stemmingToBigStrings, train.corpus)

# erase whitespaces

train.corpus <- mapply(gsub, "\\s+"," ",train.corpus)
#test.corpus  <- tm_map(test.corpus, stripWhitespace, lazy = TRUE) # dont work

# TODO fix errors in words
# TODO check stemming algorythms
# TODO play with stopwords dictionary
# TODO research sequence of text transformation for interesting cases