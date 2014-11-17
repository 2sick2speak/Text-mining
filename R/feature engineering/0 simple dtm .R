# simple document-term matrix with tf frequency

dtm <- DocumentTermMatrix(Corpus(VectorSource(train.corpus[,"essay"])))

# tf - idf term frequency
dtm.tfidf <- weightTfIdf(dtm)

# erase terms with more than 90% of sparsity

dtm <- removeSparseTerms(dtm,0.9)

# TODO erase coorelated terms
# create dtm matrix

dtm.matrix <- as.matrix(dtm)
dtm.tfidf.matrix <- as.matrix(dtm.tfidf)

# create train matrixes

train.matrix.tf <- cbind(train.corpus, dtm.matrix)
train.matrix.tfidf <- cbind(train.corpus, dtm.tfidf.matrix)