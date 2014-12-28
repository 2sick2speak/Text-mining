
source(paste0(getwd(), "/R/libraries.R"))
source(paste0(getwd(), "/R/models/0 lda.R"))


data("AssociatedPress")
# lda
lda <- clusteringLDA(AssociatedPress[1:1000,], control = list(alpha = 0.1), 5)

# posterior(lda)$topics - get topics probability
# topics(lda) - get most likely topic for each doc
# terms(lda,10) - get 10 words for each topic

# ctm

ctm <- CTM(AssociatedPress[1:1000,], k = 3)

