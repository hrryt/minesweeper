
<!-- README.md is generated from README.Rmd. Please edit that file -->

# minesweeper

<!-- badges: start -->
<!-- badges: end -->

Play minesweeper in R, replay your games and save them to GIF.

## Installation

You can install the development version of minesweeper from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("hrryt/minesweeper")
```

## Example

``` r
library(minesweeper)
dev.new(noRStudioGD = TRUE)
recording <- play_minesweeper()
replay_minesweeper(recording)
# install.packages("gifski")
save_minesweeper_gif(recording)
```
