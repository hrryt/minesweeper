hide_cells <- function(board) {
  m <- attr(board, "hide")
  if(is.null(m)) return(board)
  update_smiley(":)")
  board <- update_cells(board, "-", m)
  attr(board, "hide") <- NULL
  board
}
