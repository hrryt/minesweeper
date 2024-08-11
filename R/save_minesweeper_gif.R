#' Save Minesweeper Recording to GIF
#'
#' Save a recorded game of minesweeper to a GIF file.
#'
#' Reduce the `delay` for greater temporal resolution.
#'
#' @inheritParams replay_minesweeper
#' @inheritParams gifski::save_gif
#' @export
save_minesweeper_gif <- function(
    recording, gif_file = "animation.gif", width = 800, height = 600,
    delay = 1, loop = TRUE, progress = TRUE, ...) {
  stopifnot(
    "Package \"gifski\" must be installed to use this function." =
      requireNamespace("gifski", quietly = TRUE)
  )
  replay(recording, save_to_gif = TRUE, gif_file, width, height, delay, loop, progress, ...)
}
