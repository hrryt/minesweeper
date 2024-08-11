flag_cell <- function(board, i, j) {
  cell <- switch(
    board[[i, j]],
    `F` = "-",
    `-` = "F"
  )
  if(is.null(cell)) return(board)
  update_cell(board, cell, i, j)
}
