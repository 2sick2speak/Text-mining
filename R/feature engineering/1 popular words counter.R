# count popular words (list of popular words, text)

countPopWords <- function (vocabulary, data){
  data <- unlist(strsplit(data, " "))
  dtm <- unlist(vocabulary)
  counter <- 0
  for (i in 1:length(data)){
    if (data[i] %in% vocabulary){
      counter <- counter + 1
    } 
  }
  return (counter)
}