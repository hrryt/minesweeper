count2str <- function(count) {
  count <- rev(strsplit(as.character(count), "")[[1]])
  if(length(count) > 3) count <- count[1:3]
  counts <- rep("0", 3)
  counts[seq_along(count)] <- count
  rev(counts)
}
