# count n-grams (data - vector of texts; ngrams_number  - type of n-gram, default - 2 )

nGramsMatrix <- function(data, ngrams_number = 2){
  df <- as.data.frame(data)
  myCorpus <- Corpus(VectorSource(df$data))
  ngramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = ngrams_number, max = ngrams_number))
  tdm <- TermDocumentMatrix(myCorpus, control = list(tokenize = ngramTokenizer))
  return (tdm)
}