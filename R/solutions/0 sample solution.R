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
dtm.matrix <- createDtmMatrix (train.corpus[,"essay"], 0.90)
dtm.tfidf.matrix <- createDtmMatrix (train.corpus[,"essay"], 0.9, TRUE)

# build train matrixes
train.matrix.tf <- cbind(train.corpus$domain1_score, dtm.matrix)
colnames(train.matrix.tf)[1] <- "domain1_score"

train.matrix.tfidf <- cbind(train.corpus$domain1_score, dtm.tfidf.matrix)
colnames(train.matrix.tfidf)[1] <- "domain1_score"

# simple models

# simple lm for 1st domain score for tf
pred_lm <- lm(domain1_score ~ ., data = as.data.frame(train.matrix.tf))
summary(pred_lm)
result_lm <- predict(pred_lm,as.data.frame(train.matrix.tf))
residual <- result_lm-train.matrix.tf[,"domain1_score"]
summary(residual)
sd(residual)

# simple glm for 1st domain score for tf

pred_glm <- glm(domain1_score ~ ., data = as.data.frame(train.matrix.tf))
summary(pred_glm)
result_glm <- predict(pred_glm,as.data.frame(train.matrix.tf))
residual <- result_glm-train.matrix.tf[,"domain1_score"]
summary(residual)
sd(residual)

# simple random forest

#pred_forest <- randomForest(domain1_score ~ ., data = train.matrix.tf , ntree = 20)