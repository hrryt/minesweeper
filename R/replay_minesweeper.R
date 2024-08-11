#' Replay Minesweeper
#'
#' Replay a recorded game of minesweeper in the current graphics device.
#'
#' @param recording object of class "minesweeper_recording" returned by
#' [play_minesweeper()]
#' @returns `recording`, invisibly.
#'
#' @export
replay_minesweeper <- function(recording) {
  replay(recording, save_to_gif = FALSE)
}
