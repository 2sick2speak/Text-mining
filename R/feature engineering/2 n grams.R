# count n-grams (data - vector of texts; ngrams_number  - type of n-gram, default - 2 )

nGramsMatrix <- function(data, sparseness = 1, ngrams_number = 2, tfidf = FALSE){
  
  df <- as.data.frame(data)
  myCorpus <- Corpus(VectorSource(df$data))
  ngramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = ngrams_number, max = ngrams_number))
  
  # cheat for RWeka parallel package http://stackoverflow.com/questions/17703553/bigrams-instead-of-single-words-in-termdocument-matrix-using-r-and-rweka
  options(mc.cores=1)
  
  # create n-gram dtm
  dtm <- DocumentTermMatrix(myCorpus, control = list(tokenize = ngramTokenizer))
  
  # tf - idf term frequency   
  if (tfidf == TRUE) dtm <- weightTfIdf(dtm)
  
  # erase terms with more than N% of sparseness
  if (sparseness < 1 && sparseness > 0) dtm <- removeSparseTerms(dtm, sparseness)
  
  return (dtm)
}