replay <- function(recording, save_to_gif, delay, progress) {

  stopifnot(
    "recording must be an output of `play_minesweeper()`" =
      inherits(recording, "minesweeper_recording")
  )

  diffs <- do.call(c, lapply(recording$inputs, `[[`, "diff"))
  diffs <- diffs - diffs[1L]

  d <- dim(recording$mines)
  mine_count <- sum(recording$mines)
  board <- new_board(nrow <- d[1L], ncol <- d[2L], mine_count, recording$mines)

  timer <- 0L
  if(save_to_gif) frame <- -1
  need_first <- TRUE
  current <- start <- if(save_to_gif) as.difftime(0, units = "secs") else Sys.time()

  for(i in seq_len(len <- length(recording$inputs))) {
    if(save_to_gif && progress) cat(sprintf(
      "\r\033[0;35mCapturing input %i of %i (%.0f%%)...\033[0m",
      i, len, i/len*100
    ))
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
      on_mouse_up(input$buttons, down_buttons, input$x, input$y, board, nrow, ncol, mine_count, recording$unix)
    } else {
      down_buttons <- input$buttons
      on_mouse_down(input$buttons, input$x, input$y, board, nrow, ncol, mine_count)
    }
  }

  if(save_to_gif) {
    grid::grid.refresh()
    if (progress) cat("\n")
  }

  invisible(recording)
}
