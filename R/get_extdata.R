get_extdata <- function(path) {
  system.file("extdata", path, package = "minesweeper", mustWork = TRUE)
}
