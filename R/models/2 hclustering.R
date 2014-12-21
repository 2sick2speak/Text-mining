# HClustering clustering


hClustClustering <- function(data, method){
  distMatrix <- dist(scale(data))
  return (hclust(distMatrix, method = method))
}