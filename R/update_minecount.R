update_minecount <- function(board, count) {
  draw_count("count", count, prev_count = attr(board, "mine_count"))
  attr(board, "mine_count") <- count
  board
}
