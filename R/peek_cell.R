peek_cell <- function(board, i, j, nrow, ncol) {
  update_smiley(":0")
  update_cell(board, " ", i, j, nrow, ncol, to_hide = TRUE)
}
