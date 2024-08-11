create_viewports <- function(nrow, ncol) {

  top_height <- grid::unit(1, "inches")
  border <- grid::unit(.2, "inches")
  one <- grid::unit(1, "npc")
  bordered <- one - 2 * border
  top_bordered <- one - border
  y <- one - top_height
  aspect <- grid::unit(1.65, "snpc")

  grid::vpStack(
    grid::viewport(
      width = bordered, height = bordered
    ),
    grid::viewport(
      name = "board", x = 0.5, y = y - border,
      width = bordered, height = y - 2 * border,
      just = c("center", "top"), layout = grid::grid.layout(
        nrow, ncol, respect = TRUE, just = c("center", "top")
      )
    ),
    grid::viewport(name = "corner", layout.pos.col = 1, layout.pos.row = 1),
    grid::vpStack(
      grid::viewport(
        name = "boarder", x = 0, y = 1,
        width = ncol, height = nrow, just = c("left", "top")
      ),
      grid::vpList(
        grid::viewport(
          name = "outline", x = 0.5, y = -border,
          width = one + 2 * border, height = one + top_height + 2 * border,
          just = c("center", "bottom")
        ),
        grid::vpStack(
          grid::viewport(
            name = "top", x = 0, y = one + border,
            width = 1, height = top_height - border,
            just = c("left", "bottom")
          ),
          grid::viewport(
            width = top_bordered, height = top_bordered
          ),
          grid::vpList(
            grid::viewport(
              name = "smiley", width = grid::unit(1, "snpc")
            ),
            grid::viewport(
              name = "count", x = 0, width = aspect,
              just = c("left", "center"), layout = grid::grid.layout(
                nrow = 1, ncol = 3, just = c("left", "center")
              )
            ),
            grid::viewport(
              name = "timer", x = 1, width = aspect,
              just = c("right", "center"), layout = grid::grid.layout(
                nrow = 1, ncol = 3, just = c("right", "center")
              )
            )
          )
        )
      )
    )
  )
}
