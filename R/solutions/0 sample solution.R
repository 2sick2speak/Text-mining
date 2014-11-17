source(paste0(getwd(), "/R/libraries.R"))
source(paste0(getwd(), "/R/data processing/read_data.R"))
source(paste0(getwd(), "/R/data rearrangement/0 basic rearrangement.R"))
source(paste0(getwd(), "/R/feature engineering/0 simple dtm.R"))

# make essay list of Corpus type
train.corpus  <- essay.raw.data$train[which (essay.raw.data$train$essay_set == 8),] # use 8 type of essay
test.corpus   <- essay.raw.data$test[which (essay.raw.data$test$essay_set == 8),]  # use 8 type of essay

# data preparation
# TODO play with stopwords dictionary
train.corpus[,"essay"] <- basicRearragements(train.corpus[,"essay"], stopwords("SMART")) 
test.corpus[,"essay"]  <- basicRearragements(test.corpus[,"essay"], stopwords("SMART")) 

# create tf and tf-idf dtm
dtm.matrix <- createDtmMatrix (train.corpus[,"essay"], 0.9)
dtm.tfidf.matrix <- createDtmMatrix (train.corpus[,"essay"], 0.9, TRUE)

# build train matrixes
train.matrix.tf <- cbind(train.corpus, dtm.matrix)
train.matrix.tfidf <- cbind(train.corpus, dtm.tfidf.matrix)