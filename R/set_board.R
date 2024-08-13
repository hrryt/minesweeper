set_board <- function(board, nrow, ncol, mine_count, mines = NULL) {
  attr(board, "mines") <- if(is.null(mines))
    new_mines(nrow, ncol, mine_count) else mines
  board <- update_minecount(board, mine_count)
  attr(board, "lock") <- FALSE
  attr(board, "hide") <- matrix(FALSE, nrow, ncol)
  attr(board, "time") <- FALSE
  attr(board, "restart") <- FALSE
  draw_count("timer", 0L, NULL)
  update_smiley(":)")
  board
}
