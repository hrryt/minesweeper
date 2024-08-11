update_timer <- function(board, count, prev_count) {
  if(attr(board, "lock") || !attr(board, "time")) return(prev_count)
  count <- as.integer(ceiling(as.double(count, units = "secs")))
  draw_count("timer", count, prev_count)
}
