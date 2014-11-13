# stopwords removal for big data

stopWordsRemove <- function(data, dictionary){
  for (i in 1:length(dictionary)){
    # concatenate regular expression with stopword and erase it
    data <- gsub(paste(c("(^|\\W)", dictionary[i],"(\\W|$)"), collapse=""), " ", data)
  }
  return (data)
}
