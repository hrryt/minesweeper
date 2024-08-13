hide_cells <- function(board) {
  m <- attr(board, "hide")
  update_smiley(":)")
  board <- update_cells(board, "-", m)
  attr(board, "hide")[] <- FALSE
  board
}
