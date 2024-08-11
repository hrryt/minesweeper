neighbors <- function(i, j, nrow, ncol) {
  is <- (i-1):(i+1)
  js <- (j-1):(j+1)
  is <- is[is <= nrow & is != 0]
  js <- js[js <= ncol & js != 0]
  cbind(rep(is, each = length(js)), js)
}
