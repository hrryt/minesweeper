chord <- function(board, i, j, nrow, ncol) {
  nbors <- neighbors(i, j, nrow, ncol)
  if(sum((bn <- board[nbors]) == "F") == sum(attr(board, "mines")[nbors]))
    return(reveal_surrounding(board, nbors, nrow, ncol))
  if(.chordflag && sum((blanks <- bn == "-") | bn == "F") == board[[i, j]]) {
    return(update_neighbors(board, "F", nbors, blanks, nrow, ncol))
  }
  board
}

.chordflag <- FALSE
