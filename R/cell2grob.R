cell2grob <- function(cell) {
  switch(
    as.character(cell),
    `-` = hidden,
    ` ` = blank,
    `F` = flag,
    `m` = mine,
    `M` = explosion,
    `X` = not_mine,
    number[[as.integer(cell)]]
  )
}
