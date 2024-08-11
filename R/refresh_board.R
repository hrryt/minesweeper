refresh_board <- function(board, nrow, ncol, mine_count) {
  board <- set_board(board, nrow, ncol, mine_count)
  update_cells(board, "-", board != "-")
}
