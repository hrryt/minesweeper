on_mouse_up <- function(buttons, j, i, board, nrow, ncol, mine_count) {
  board <- hide_cells(board)
  if(no_play(board, i, j, nrow, ncol)) return(board)
  attr(board, "time") <- TRUE
  if(0 %in% buttons) {
    board <- if(board[[i, j]] %in% 1:8)
      chord(board, i, j, nrow, ncol) else
        reveal(board, i, j, nrow, ncol)
  }
  if(sum(board == "-") == mine_count) {
    update_smiley("B)")
    attr(board, "lock") <- TRUE
  }
  update_minecount(board, mine_count - sum(board == "F" | board == "X"))
}
