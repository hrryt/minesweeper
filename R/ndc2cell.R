ndc2cell <- function(x, y, vp = "corner") {
  x <- graphics::grconvertX(x, "ndc", "inches")
  y <- graphics::grconvertY(y, "ndc", "inches")
  grid::seekViewport(vp)
  cell <- grid::deviceLoc(grid::unit(0:1, "npc"), grid::unit(1:0, "npc"))
  grid::seekViewport("board")
  cell <- lapply(cell, `attributes<-`, NULL)
  ceiling(c(x = interpolate(x, cell$x), y = interpolate(y, cell$y)))
}
