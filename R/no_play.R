no_play <- function(board, i, j, nrow, ncol) {
  attr(board, "lock") || !on_board(i, j, nrow, ncol)
}
