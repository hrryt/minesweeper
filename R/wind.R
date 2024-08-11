wind <- function(vp = NULL, reverse = FALSE, fill = TRUE) {
  if(!is.null(vp)) grid::seekViewport(vp)
  col <- c("#808080ff", "#ffffff")
  if(reverse) col <- rev(col)
  grid::grid.polyline(
    x = c(0,0,1,1,1,0), y = c(0,1,1,1,0,0), id = rep(1:2, each = 3),
    gp = grid::gpar(col = col, lwd = 10, lineend = "butt", linejoin = "mitre")
  )
  if(fill) grid::grid.rect(gp = grid::gpar(fill = "#c0c0c0ff", col = NA))
}
