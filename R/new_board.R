new_board <- function(nrow, ncol, mine_count = NULL, mines = NULL) {
  new_mineplot(nrow, ncol)
  board <- matrix("-", nrow, ncol)
  set_board(board, nrow, ncol, mine_count, mines)
}
