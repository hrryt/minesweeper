update_cells <- function(board, cell, m, to_hide = FALSE) {
  where <- which(m, arr.ind = TRUE)
  for(r in seq_len(nrow(where))) {
    draw_cell(cell, where[[r, "row"]], where[[r, "col"]])
  }
  if(to_hide) attr(board, "hide") <- m
  board[m] <- cell
  board
}
