update_smiley <- function(which) {
  grid::seekViewport("smiley")
  grid::grid.draw(smiley[[which]])
  grid::seekViewport("board")
}
