# count amount of words in sentence

wordsCounter <- function(str){
  return (sapply(gregexpr("\\W+", str), length) + 1)
}