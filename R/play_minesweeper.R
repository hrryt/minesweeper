#' Start a Minesweeper Game
#'
#' Play minesweeper interactively in the current graphics device.
#'
#' Expert difficulty is 16x30 with 99 mines, intermediate 16x16 with 40 mines,
#' and beginner 9x9 with 10 mines.
#'
#' The current graphics device must support event handling
#' (see [grDevices::getGraphicsEvent()]). If `onIdle` is not supported,
#' the timer will only update on mouse events.
#'
#' @section Controls:
#'
#' * **Left click** an empty square to reveal it.
#'
#' * **Right click** an empty square to flag it.
#'
#' * **Middle click** a number to reveal its adjacent squares.
#'
#' * Press **r** to reset the board.
#'
#' * Press **q** to quit.
#'
#' @param difficulty establishes default dimensions and mine count
#' @param nrow,ncol dimensions of the minesweeper board
#' @param mine_count number of mines to sweep
#' @param mine_density proportion of cells that conceal a mine
#' @param os_type used to interpret `button` argument of event handlers
#' @returns Object of class "minesweeper_recording" to pass to
#' [replay_minesweeper()] or [save_minesweeper_gif()], invisibly.
#' @examplesIf .Platform$OS.type == "unix" && interactive()
#' x11() # Unix-specific example
#' recording <- play_minesweeper()
#' dev.off()
#' @export
play_minesweeper <- function(
    difficulty = c("expert", "intermediate", "beginner"),
    nrow = NULL, ncol = NULL,
    mine_count = NULL, mine_density = NULL,
    os_type = c("guess", "unix", "windows")) {

  os_type <- match.arg(os_type)
  if(os_type == "guess") os_type <- .Platform$OS.type
  unix <- os_type == "unix"

  dev_cur <- tolower(substr(names(grDevices::dev.cur()), 1, 3))
  if(unix && dev_cur != "x11") warning("try x11()")
  if(!unix && dev_cur != "win") warning("try windows()")

  board <- switch(
    match.arg(difficulty),
    expert = c(16, 30, 99),
    intermediate = c(16, 16, 40),
    beginner = c(9, 9, 10)
  )

  if(is.null(nrow)) nrow <- board[[1]]
  if(is.null(ncol)) ncol <- board[[2]]
  if(is.null(mine_count)) mine_count <- if(is.null(mine_density))
    board[[3]] else as.integer(nrow * ncol * mine_density)

  stopifnot(nrow * ncol >= mine_count)
  board <- new_board(nrow, ncol, mine_count)

  inputs <- list()
  frame <- 1L
  down_buttons <- NULL
  timer <- 0L
  need_first <- TRUE
  first <- NULL
  mouse_pos <- c(0L, 0L)

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

  onMouseMove <- function(buttons, x, y) {
    devset()
    if(need_first && attr(board, "time")) {
      need_first <<- FALSE
      first <<- Sys.time()
    }
    timer <<- update_timer(board, Sys.time() - first, timer)
    cell <- ndc2cell(x, y)
    x <- cell[["x"]]
    y <- cell[["y"]]
    if(any(mouse_pos != c(x, y))) {
      board <<- hide_cells(board)
      if(length(buttons) != 0) {
        board <<- on_mouse_down(
          buttons, x, y, board, nrow, ncol, mine_count, flag = FALSE
        )
      }
    }
    mouse_pos <<- c(x, y)
    down_buttons <<- buttons
    NULL
  }

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
      up = FALSE, buttons = buttons, x = x, y = y, diff = current
    )
    frame <<- frame + 1L
    board <<- on_mouse_down(buttons, x, y, board, nrow, ncol, mine_count)
    down_buttons <<- buttons
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
      up = TRUE, buttons = buttons, x = x, y = y, diff = current
    )
    frame <<- frame + 1L
    board <<- on_mouse_up(buttons, down_buttons, x, y, board, nrow, ncol, mine_count, unix)
    down_buttons <<- buttons
    if(need_first && attr(board, "time")) {
      need_first <<- FALSE
      first <<- Sys.time()
    }
    timer <<- update_timer(board, Sys.time() - first, timer)
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
    onIdle = if(unix) onIdle,
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
  out <- list(inputs = inputs, mines = attr(board, "mines"), unix = unix)
  class(out) <- "minesweeper_recording"
  invisible(out)
}
