
source(paste0(getwd(), "/R/libraries.R"))
source(paste0(getwd(), "/R/models/0 lda.R"))


data("AssociatedPress")

lda <- clusteringLDA(AssociatedPress[1:1000,], control = list(alpha = 0.1), 3)

