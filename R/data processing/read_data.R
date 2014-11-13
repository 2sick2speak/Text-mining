# read data about essays

essay.raw.data <- list()

essay.raw.data$train <- read.csv(paste0(getwd(), "/data/raw/training_set_rel3.tsv"), sep = "\t", stringsAsFactors = FALSE) 
essay.raw.data$test <- read.csv(paste0(getwd(), "/data/raw/test_set.tsv"), sep = "\t", stringsAsFactors = FALSE) 