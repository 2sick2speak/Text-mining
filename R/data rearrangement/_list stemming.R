# apply wordStem to big strings and lists

stemmingToBigStrings <- function(data){
  # split string to words and apply wordStem
  data <- lapply(strsplit(data, " "), wordStem)
  # concatenate string back
  return (paste(unlist(data),collapse = " "))
}
