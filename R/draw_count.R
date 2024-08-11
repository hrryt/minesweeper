draw_count <- function(vp, count, prev_count) {
  if(use_prev <- (!is.null(prev_count)) && count == prev_count) return(count)
  grid::seekViewport(vp)
  on.exit(grid::seekViewport("board"))
  countstr <- count2str(count)
  grobs <- counter[countstr]
  names(grobs) <- 1:3
  if(use_prev) grobs[countstr == count2str(prev_count)] <- NULL
  cols <- as.numeric(names(grobs))
  for(i in seq_along(grobs)) {
    grid::pushViewport(grid::viewport(layout.pos.col = cols[[i]], layout.pos.row = 1))
    grid::grid.draw(grobs[[i]])
    grid::popViewport()
  }
  count
}
