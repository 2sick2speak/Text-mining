source(paste0(getwd(), "/R/libraries.R"))
source(paste0(getwd(), "/R/data processing/read_data.R"))
source(paste0(getwd(), "/R/data rearrangement/0 basic rearrangement.R"))

# make essay list of Corpus type
train.corpus  <- essay.raw.data$train[which (essay.raw.data$train$essay_set == 8),] # use 8 type of essay
test.corpus   <- essay.raw.data$test[which (essay.raw.data$test$essay_set == 8),]  # use 8 type of essay


# TODO play with stopwords dictionary
train.corpus[,"essay"] <- basicRearragements(train.corpus[,"essay"], stopwords("SMART")) 
test.corpus[,"essay"]  <- basicRearragements(test.corpus[,"essay"], stopwords("SMART")) 