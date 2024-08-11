update_neighbors <- function(board, cell, nbors, m, nrow, ncol, to_hide = FALSE) {
  mat <- matrix(FALSE, nrow, ncol)
  mat[nbors][m] <- TRUE
  update_cells(board, cell, mat, to_hide = to_hide)
}
