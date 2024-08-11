new_mines <- function(nrow, ncol, mine_count) {
  mines <- matrix(FALSE, nrow, ncol)
  mines[sample.int(nrow*ncol, mine_count)] <- TRUE
  mines
}

