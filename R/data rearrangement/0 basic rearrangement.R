source(paste0(getwd(), "/R/data rearrangement/_list stemming.R"))
source(paste0(getwd(), "/R/data rearrangement/_stop words removal.R"))

#additional stopwords
# additional.stopwords <- c("dont")

# make essay list of Corpus type
train.corpus  <- essay.raw.data$train[which (essay.raw.data$train$essay_set == 8),] # use 8 type of essay
test.corpus   <- essay.raw.data$test[which (essay.raw.data$test$essay_set == 8),]  # use 8 type of essay

# erase @-like words 

train.corpus[,"essay"] <- mapply(gsub, "@\\w+","",train.corpus[,"essay"])
test.corpus[,"essay"] <- mapply(gsub, "@\\w+","",test.corpus[,"essay"])

# remove punctuation

train.corpus[,"essay"] <- mapply(gsub, "\\W+"," ",train.corpus[,"essay"])
test.corpus[,"essay"] <- mapply(gsub, "\\W+"," ",test.corpus[,"essay"])

# remove numbers

train.corpus[,"essay"] <- mapply(gsub, "\\d+"," ",train.corpus[,"essay"])
test.corpus[,"essay"] <- mapply(gsub, "\\d+"," ",test.corpus[,"essay"])

# to lower case

train.corpus[,"essay"] <- mapply(tolower,train.corpus[,"essay"])
test.corpus[,"essay"] <- mapply(tolower,test.corpus[,"essay"])

# remove stopwords
# FUCKIN TIME CONSUMING OPERATION 20m+ for 8k texts. Better read from file 

# FIXIT 
# train.corpus[,"essay"] <- as.matrix(lapply(train.corpus[,"essay"], stopWordsRemove, stopwords("SMART")))[1,]
# test.corpus[,"essay"] <- as.matrix(lapply(test.corpus[,"essay"], stopWordsRemove, stopwords("SMART")))[1,]


# stem words

train.corpus[,"essay"] <- mapply(stemmingToBigStrings, train.corpus[,"essay"])
test.corpus[,"essay"] <- mapply(stemmingToBigStrings, test.corpus[,"essay"])

# erase whitespaces

train.corpus[,"essay"] <- mapply(gsub, "\\s+"," ",train.corpus[,"essay"])
test.corpus[,"essay"] <- mapply(gsub, "\\s+"," ",test.corpus[,"essay"])

# return colnames

colnames(train.corpus) <- names.storage
colnames(test.corpus)  <- names.storage

# TODO fix errors in words
# TODO check stemming algorythms
# TODO play with stopwords dictionary
# TODO research sequence of text transformation for interesting cases