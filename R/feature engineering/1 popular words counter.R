# count popular words

countPopWords <- function (dtm, data){
  data <- unlist(strsplit(data, " "))
  dtm <- unlist(dtm)
  counter <- 0
  for (i in 1:length(data)){
    if (data[i] %in% dtm){
      counter <- counter + 1
    } 
  }
  return (counter)
}