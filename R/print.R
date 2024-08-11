#' @export
print.minesweeper_recording <- function(x, ...) {
  time <- x$inputs[[length(x$inputs)]]$diff
  cat(sprintf("Minesweeper recording of %f %s\n", time, units(time)))
}
