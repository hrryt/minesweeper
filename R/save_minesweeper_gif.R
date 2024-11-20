#' Save a Minesweeper Recording to GIF
#'
#' Save a recorded game of minesweeper to a GIF file.
#'
#' Reduce the `delay` for greater temporal resolution.
#'
#' @inheritParams replay_minesweeper
#' @inheritParams gifski::save_gif
#' @returns The file path of the GIF file.
#' @examplesIf .Platform$OS.type == "unix" && interactive() && requireNamespace("gifski", quietly = TRUE)
#' x11() # Unix-specific example
#' recording <- play_minesweeper()
#' save_minesweeper_gif(recording)
#' dev.off()
#' @export
save_minesweeper_gif <- function(
    recording, gif_file = "animation.gif", width = 800, height = 600,
    delay = 1, loop = TRUE, progress = TRUE, ...) {

  stopifnot(
    "Package \"gifski\" must be installed to use this function." =
      requireNamespace("gifski", quietly = TRUE)
  )

  imgdir <- tempfile("tmppng")
  dir.create(imgdir)
  on.exit(unlink(imgdir, recursive = TRUE), add = TRUE)
  filename <- file.path(imgdir, "tmpimg_%05d.png")
  grDevices::png(filename, width = width, height = height, ...)
  oldpar <- graphics::par(ask = FALSE)
  on.exit(graphics::par(oldpar), add = TRUE)

  tryCatch(
    replay(recording, save_to_gif = TRUE, delay, progress),
    finally = grDevices::dev.off()
  )

  images <- list.files(imgdir, pattern = "tmpimg_\\d{5}.png", full.names = TRUE)
  frames <- c(seq_along(images), rep.int(length(images), 1 %/% delay))
  gifski::gifski(
    images[frames], gif_file = gif_file, width = width, height = height,
    delay = delay, loop = loop, progress = progress
  )
}
