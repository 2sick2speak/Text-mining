# LDA clustering

clusteringLDA <- function(data, control, NumClusters){
  return (LDA(data, control = control, k = NumClusters))
}