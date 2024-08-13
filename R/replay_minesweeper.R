#' Replay a Minesweeper Recording
#'
#' Replay a recorded game of minesweeper in the current graphics device.
#'
#' @param recording object of class "minesweeper_recording" returned by
#' [play_minesweeper()]
#' @returns `recording`, invisibly.
#' @examplesIf interactive()
#' dev.new(noRStudioGD = TRUE)
#' recording <- play_minesweeper()
#' replay_minesweeper(recording)
#' dev.off()
#' @export
replay_minesweeper <- function(recording) {
  replay(recording, save_to_gif = FALSE)
}
