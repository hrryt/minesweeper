update_cell <- function(board, cell, i, j, nrow, ncol, to_hide = FALSE) {
  draw_cell(cell, i, j)
  board[[i, j]] <- cell
  if(to_hide) attr(board, "hide")[[i, j]] <- TRUE
  board
}
