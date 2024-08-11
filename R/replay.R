replay <- function(recording, save_to_gif, gif_file, width, height, delay, loop, progress, ...) {

  stopifnot(
    "recording must be an output of `play_minesweeper()`" =
      inherits(recording, "minesweeper_recording")
  )

  if(save_to_gif) {
    imgdir <- tempfile("tmppng")
    dir.create(imgdir)
    on.exit(unlink(imgdir, recursive = TRUE))
    filename <- file.path(imgdir, "tmpimg_%05d.png")
    grDevices::png(filename, width = width, height = height, ...)
    graphics::par(ask = FALSE)
    # grDevices::dev.set(grDevices::dev.prev())
  }

  diffs <- do.call(c, lapply(recording$inputs, `[[`, "diff"))
  diffs <- diffs - diffs[1L]

  d <- dim(recording$mines)
  mine_count <- sum(recording$mines)
  board <- new_board(nrow <- d[1L], ncol <- d[2L], mine_count, recording$mines)

  timer <- 0L
  if(save_to_gif) frame <- -1
  need_first <- TRUE
  current <- start <- if(save_to_gif) as.difftime(0, units = "secs") else Sys.time()

  for(i in seq_along(recording$inputs)) {
    while((interval <- current - start) <= diffs[[i]]) {
      current <- if(save_to_gif) current + delay else Sys.time()
      if(need_first && attr(board, "time")) {
        need_first <- FALSE
        first <- current
      }
      timer <- update_timer(board, current - first, timer)
      if(save_to_gif) grid::grid.refresh()
    }
    input <- recording$inputs[[i]]
    board <- if(input$up) {
      on_mouse_up(down_buttons, input$x, input$y, board, nrow, ncol, mine_count)
    } else {
      down_buttons <- input$buttons
      on_mouse_down(input$buttons, input$x, input$y, board, nrow, ncol, mine_count)
    }
  }

  if(save_to_gif) {
    grid::grid.refresh()
    grDevices::dev.off()#grDevices::dev.next())
    images <- list.files(imgdir, pattern = "tmpimg_\\d{5}.png", full.names = TRUE)
    frames <- c(seq_along(images), rep.int(length(images), 1 %/% delay))
    gifski::gifski(
      images[frames], gif_file = gif_file, width = width, height = height,
      delay = delay, loop = loop, progress = progress
    )
  }

  invisible(recording)
}
