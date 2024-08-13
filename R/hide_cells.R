hide_cells <- function(board) {
  m <- attr(board, "hide")
  if(!any(m)) return(board)
  update_smiley(":)")
  board <- update_cells(board, "-", m)
  attr(board, "hide")[] <- FALSE
  board
}
