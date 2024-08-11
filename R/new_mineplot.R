new_mineplot <- function(nrow, ncol) {
  grid::grid.newpage()
  grid::grid.rect(gp = grid::gpar(fill = "black", col = NA))
  grid::pushViewport(create_viewports(nrow, ncol))
  wind("outline", reverse = TRUE)
  wind("top")
  wind("boarder", fill = FALSE)
  grid::seekViewport("board")
  for(r in seq_len(nrow)) for(c in seq_len(ncol)) draw_raster(hidden, r, c)
}
