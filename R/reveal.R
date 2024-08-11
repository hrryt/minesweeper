reveal <- function(board, i, j, nrow, ncol) {
  if(board[[i, j]] != "-") return(board)
  if(attr(board, "mines")[[i, j]]) {
    update_smiley("X(")
    board <- update_cell(board, "M", i, j)
    board <- update_cells(board, "m", board == "-" & attr(board, "mines"))
    board <- update_cells(board, "X", board == "F" & !attr(board, "mines"))
    attr(board, "lock") <- TRUE
    return(board)
  }
  nbors <- neighbors(i, j, nrow, ncol)
  if((surrounding_mines <- sum(attr(board, "mines")[nbors])) == 0) {
    board <- update_cell(board, " ", i, j)
    return(reveal_surrounding(board, nbors, nrow, ncol))
  }
  update_cell(board, surrounding_mines, i, j)
}
