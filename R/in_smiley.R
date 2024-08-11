in_smiley <- function(x, y) {
  all(ndc2cell(x, y, vp = "smiley") == 1)
}
