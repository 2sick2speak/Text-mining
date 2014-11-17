source(paste0(getwd(), "/R/data rearrangement/_list stemming.R"))
source(paste0(getwd(), "/R/data rearrangement/_stop words removal.R"))

basicRearragements <- function(data, dictionary){
  # erase @-like words 
  data <- mapply(gsub, "@\\w+","",data)
  
  # remove punctuation  
  data <- mapply(gsub, "\\W+"," ",data)
  
  # remove numbers
  data <- mapply(gsub, "\\d+"," ",data)

  # to lower case  
  data <- mapply(tolower,data)
  
  # remove stopwords
  # FUCKIN TIME CONSUMING OPERATION 20m+ for 8k texts. Better read from file 
  data <- as.character(lapply(data, stopWordsRemove, dictionary))
    
  # stem words
  data <- mapply(stemmingToBigStrings, data)
  
  # erase whitespaces  
  data <- mapply(gsub, "\\s+"," ",data)
  
  return (data)
  
}

# TODO fix errors in words
# TODO check stemming algorythms
# TODO research sequence of text transformation for interesting cases