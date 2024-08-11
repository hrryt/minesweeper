#' Play Minesweeper
#'
#' Start a minesweeper game in the current graphics device.
#'
#' The current graphics device must support event handling
#' (see [grDevices::getGraphicsEvent()]). On the `windows()` device,
#' the timer will only update upon mouse events as `onIdle` is not supported.
#'
#' @param nrow,ncol dimensions of the minesweeper board
#' @param mine_count number of mines to sweep
#' @param mine_density proportion of cells that conceal a mine
#' @returns Object of class "minesweeper_recording" to pass to
#' [replay_minesweeper()], invisibly.
#' @examplesIf interactive()
#' dev.new(noRStudioGD = TRUE)
#' try(recording <- play_minesweeper())
#' @export
play_minesweeper <- function(
    nrow = 16, ncol = 30,
    mine_count = mine_density * nrow * ncol, mine_density = 0.20625) {

  board <- new_board(nrow, ncol, mine_count)

  inputs <- list()
  frame <- 1L
  down_buttons <- NULL
  timer <- 0L
  need_first <- TRUE
  first <- NULL

  devset <- function() {
    if (grDevices::dev.cur() != eventEnv$which)
      grDevices::dev.set(eventEnv$which)
  }

  onIdle <- function() {
    devset()
    if(need_first && attr(board, "time")) {
      need_first <<- FALSE
      first <<- Sys.time()
    }
    timer <<- update_timer(board, Sys.time() - first, timer)
    NULL
  }

  if(names(grDevices::dev.cur()) == "windows") {
    onMouseMove <- onIdle
    formals(onMouseMove) <- alist(buttons =, x =, y =)
    onIdle <- NULL
  } else onMouseMove <- NULL

  onMouseDown <- function(buttons, x, y) {
    devset()
    if(0 %in% buttons && in_smiley(x, y)) {
      update_smiley("|:)")
      attr(board, "restart") <- TRUE
    }
    cell <- ndc2cell(x, y)
    x <- cell[["x"]]
    y <- cell[["y"]]
    current <- Sys.time()
    inputs[[frame]] <<- list(
      up = FALSE, buttons = buttons, x = x, y = y,
      diff = current
    )
    frame <<- frame + 1L
    down_buttons <<- buttons
    board <<- on_mouse_down(buttons, x, y, board, nrow, ncol, mine_count)
    NULL
  }

  onMouseUp <- function(buttons, x, y) {
    devset()
    smile <- in_smiley(x, y)
    cell <- ndc2cell(x, y)
    x <- cell[["x"]]
    y <- cell[["y"]]
    current <- Sys.time()
    inputs[[frame]] <<- list(
      up = TRUE, buttons = buttons, x = x, y = y,
      diff = current
    )
    frame <<- frame + 1L
    board <<- on_mouse_up(down_buttons, x, y, board, nrow, ncol, mine_count)
    if(need_first && attr(board, "time")) {
      need_first <<- FALSE
      first <<- Sys.time()
    }
    timer <<- update_timer(board, Sys.time() - first, timer)
    down_buttons <<- NULL
    if(attr(board, "restart")) {
      update_smiley(":)")
      if(smile) {
        board <<- refresh_board(board, nrow, ncol, mine_count)
        timer <<- 0L
        need_first <<- TRUE
        inputs <<- list()
        frame <<- 1L
      }
    }
    NULL
  }

  onKeybd <- function(key) {
    devset()
    if(key == "q") return(invisible(1))
    if(key == "r") {
      board <<- refresh_board(board, nrow, ncol, mine_count)
      timer <<- 0L
      need_first <<- TRUE
      inputs <<- list()
      frame <<- 1L
    }
    NULL
  }

  grDevices::setGraphicsEventHandlers(
    onIdle = onIdle,
    onMouseMove = onMouseMove,
    onMouseDown = onMouseDown,
    onMouseUp = onMouseUp,
    onKeybd = onKeybd,
  )

  eventEnv <- grDevices::getGraphicsEventEnv()

  grDevices::getGraphicsEvent(
    consolePrompt = "Left click: reveal\nRight click: flag\nMiddle click: peek\nr: reset\nq: quit"
  )

  for(i in seq_along(inputs)) inputs[[i]]$diff <- inputs[[i]]$diff - first
  out <- list(inputs = inputs, mines = attr(board, "mines"))
  class(out) <- "minesweeper_recording"
  invisible(out)
}
