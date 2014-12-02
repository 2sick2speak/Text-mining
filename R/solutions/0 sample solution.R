source(paste0(getwd(), "/R/libraries.R"))
source(paste0(getwd(), "/R/data processing/read_data.R"))
source(paste0(getwd(), "/R/data rearrangement/0 basic rearrangement.R"))
source(paste0(getwd(), "/R/feature engineering/_words counter.R"))
source(paste0(getwd(), "/R/feature engineering/1 popular words counter.R"))
source(paste0(getwd(), "/R/feature engineering/2 n grams.R"))



# make essay list of Corpus type
train.corpus  <- essay.raw.data$train[which (essay.raw.data$train$essay_set == 8),] # use 8 type of essay
#test.corpus   <- essay.raw.data$test[which (essay.raw.data$test$essay_set == 8),]  # use 8 type of essay

# data preparation
# TODO convert past form into infinitive: did -> do; adjective: easier -> easy
# TODO erase transition words https://github.com/Gxav73/Gxav_Sol_ASAP_round2/blob/master/transition_words.csv 
# additional stopwords

add.vocabulary <- read.csv(paste0(getwd(), "/data/vocabularies/additional stopwords.txt"))
add.vocabulary <- as.character(add.vocabulary[1:length(add.vocabulary[,1]), ])
stop.words.vocabulary <- unique(c(add.vocabulary, stopwords("SMART"))) 

train.corpus[,"essay"] <- basicRearragements(train.corpus[,"essay"], stop.words.vocabulary) 
#test.corpus[,"essay"]  <- basicRearragements(test.corpus[,"essay"], stopwords("SMART")) 

# count amount of words
nwords <- as.matrix(mapply(wordsCounter, train.corpus[,"essay"]))
row.names(nwords) <- NULL

# create tf and tf-idf dtm
dtm.matrix <- as.matrix(nGramsMatrix (train.corpus[,"essay"], ngrams_number = 1, sparseness = 0.90))
#dtm.tfidf.matrix <- createDtmMatrix (train.corpus[,"essay"], 0.9, TRUE)

# count popular words

popwords <- as.matrix(mapply(countPopWords, list(colnames(dtm.matrix)), train.corpus$essay))
unpopwords <- mapply(length, strsplit(train.corpus$essay, " ")) - popwords


# create 2-gram matrix

ngram.matrix <- nGramsMatrix(train.corpus[,"essay"], ngrams_number = 2)

# build train matrixes
train.matrix.tf <- cbind(nwords, dtm.matrix)
train.matrix.tf <- cbind(popwords, train.matrix.tf)
train.matrix.tf <- cbind(unpopwords, train.matrix.tf)
train.matrix.tf <- cbind(train.corpus$domain1_score, train.matrix.tf)

colnames(train.matrix.tf)[1] <- "domain1_score"
colnames(train.matrix.tf)[2] <- "unpopwords"
colnames(train.matrix.tf)[3] <- "popwords"
colnames(train.matrix.tf)[4] <- "num_words" 


#train.matrix.tfidf <- cbind(train.corpus$domain1_score, dtm.tfidf.matrix)
#colnames(train.matrix.tfidf)[1] <- "domain1_score"

# simple models

# simple lm for 1st domain score for tf
pred_lm <- lm(domain1_score ~ ., data = as.data.frame(train.matrix.tf))
summary(pred_lm)
result_lm <- predict(pred_lm,as.data.frame(train.matrix.tf))
residual <- result_lm-train.matrix.tf[,"domain1_score"]
summary(residual)
sd(residual)

# simple glm for 1st domain score for tf

pred_glm <- glm(domain1_score ~ ., data = as.data.frame(train.matrix.tf), family=quasipoisson(link=log))
#pred_glm <- glm(domain1_score ~ offset(log(num_words)) + ., as.data.frame(train.matrix.tf),  family=poisson(link=log) )
summary(pred_glm)
result_glm <- predict(pred_glm,as.data.frame(train.matrix.tf))
residual <- result_glm-train.matrix.tf[,"domain1_score"]
summary(residual)
sd(residual)

# simple random forest

#pred_forest <- randomForest(domain1_score ~ ., data = as.data.frame(train.matrix.tf))

# simple svm

pred_svm <- svm(domain1_score ~ ., data = as.data.frame(train.matrix.tf))
summary(pred_svm)
result_svm <- predict(pred_svm,as.data.frame(train.matrix.tf))
residual <- result_svm-train.matrix.tf[,"domain1_score"]
summary(residual)
sd(residual) #1.999288, with custom vocabulary 1.980084

# graph
plot(train.matrix.tf[,"domain1_score"], result_svm, col = "red")

