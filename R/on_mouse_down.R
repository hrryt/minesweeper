on_mouse_down <- function(buttons, j, i, board, nrow, ncol, mine_count, flag = TRUE) {
  if(no_play(board, i, j, nrow, ncol)) return(board)
  if(flag && 2 %in% buttons) board <- flag_cell(board, i, j)
  nbors <- neighbors(i, j, nrow, ncol)
  blanks <- board[nbors] == "-"
  if(board[[i, j]] == "-") {
    if(0 %in% buttons) board <- peek_cell(board, i, j, nrow, ncol)
    if(1 %in% buttons) board <- peek_neighbors(board, nbors, blanks, nrow, ncol)
  } else if(0 %in% buttons && board[[i, j]] %in% 1:8) {
    board <- peek_neighbors(board, nbors, blanks, nrow, ncol)
  }
  update_minecount(board, mine_count - sum(board == "F" | board == "X"))
}
