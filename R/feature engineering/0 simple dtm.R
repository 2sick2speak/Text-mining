# simple document-term matrix with tf frequency
createDtmMatrix <- function(data, sparseness, tfidf = FALSE){
  
  dtm <- DocumentTermMatrix(Corpus(VectorSource(data)))
  
  # tf - idf term frequency 
  
  if (tfidf == TRUE) dtm <- weightTfIdf(dtm)
  
  # erase terms with more than N% of sparseness
  dtm <- removeSparseTerms(dtm,sparseness)
  
  #create matrix
  dtm.matrix <- as.matrix(dtm)
  
  return (dtm.matrix)
  
}
