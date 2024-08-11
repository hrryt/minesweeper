reveal_surrounding <- function(board, nbors, nrow, ncol) {
  for(row in seq_len(nrow(nbors))) {
    board <- reveal(board, nbors[row, 1], nbors[row, 2], nrow, ncol)
  }
  board
}
