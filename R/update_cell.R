update_cell <- function(board, cell, i, j, nrow, ncol, to_hide = FALSE) {
  draw_cell(cell, i, j)
  board[[i, j]] <- cell
  if(to_hide) {
    m <- matrix(FALSE, nrow, ncol)
    m[[i, j]] <- TRUE
    attr(board, "hide") <- m
  }
  board
}
