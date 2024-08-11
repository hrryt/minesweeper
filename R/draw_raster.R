draw_raster <- function(grob, i, j) {
  grid::pushViewport(grid::viewport(layout.pos.col = j, layout.pos.row = i))
  grid::grid.draw(grob)
  grid::popViewport()
}
