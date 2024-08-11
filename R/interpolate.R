interpolate <- function(x, cellx) {
  (x - cellx[1]) / (cellx[2] - cellx[1])
}
