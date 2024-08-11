sprites <- magick::image_read(
  "https://raw.githubusercontent.com/anton-fomichev/minesweeper-ts-2023/master/src/assets/minesweeper-sprites.png"
)
sprite <- function(..., sheet = sprites) {
  grid::rasterGrob(
    magick::image_crop(sheet, magick::geometry_area(...)),
    interpolate = FALSE
  )
}
hidden <- sprite(16,16,0,51)
blank <- sprite(16,16,17,51)
flag <- sprite(16,16,34,51)
mine <- sprite(16,16,85,51)
explosion <- sprite(16,16,102,51)
not_mine <- sprite(16,16,119,51)
number <- lapply(0:7 * 17, \(n) sprite(16,16,n,68))
counter <- setNames(lapply(0:9 * 14, \(n) sprite(13,23,n,0)), c(1:9, 0))
smiley <- setNames(
  lapply(0:4 * 27, \(n) sprite(26,26,n,24)),
  c(":)", "|:)", ":0", "B)", "X(")
)
usethis::use_data(
  hidden, blank, flag, mine, explosion, not_mine, number, counter, smiley,
  internal = TRUE, overwrite = TRUE
)
