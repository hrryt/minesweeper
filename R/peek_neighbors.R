peek_neighbors <- function(board, nbors, blanks, nrow, ncol) {
  update_smiley(":0")
  update_neighbors(board, " ", nbors, blanks, nrow, ncol, to_hide = TRUE)
}
