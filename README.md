# diffr2 for nice diffs

R package for creating code differences with JavaScript based on:

[diff2html](https://github.com/rtfpessoa/diff2html) and [jsdiff](https://github.com/kpdecker/jsdiff). This package is not related with the CRAN package `diffr` (the sole reminiscence is the name).

With `create_diff()` it is possible to create diffs from characters or text files (either both inputs are text files or they are text files) and compare them interactively in the form of an `htmlwidget`. If the latter is chosen, other local diffs, e.g. from Git repositories can be used. For instance with [`gert`](https://github.com/r-lib/gert) see the example below. `diffr2` can use various options to change the appearance of the diff, e.g. display both inputs side by side. Similarly it is possible to create diffs with [`libxdiffR`](https://github.com/JanMarvin/libxdiffR)

If necessary, `diffr2` can be used in combination with [`shiny`](https://shiny.rstudio.com/). An example file is included.

## Installation

Either with `remotes::install_github("JanMarvin/diffr2")` or via r-universe:

```R
# Enable repository from janmarvin
options(repos = c(
  janmarvin = 'https://janmarvin.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'))
# Download and install diffr2 in R
install.packages('diffr2')
```


## Code example

``` r
library(diffr2)

a <- '<a><b foo="bar"/></a>'
b <- '<a><b foo="bar">baz</b></a>'

# side by side comparisson
diffr2(a, b)

# raw diff
message(create_diff(a, b))

# git diff in side by side format
git_head <- paste(gert::git_diff_patch(ref = "HEAD^", repo = "."), collapse = "\n")
diffr2(diff = git_head, outputFormat = "side-by-side")

# read github commit as diff
tmp <- tempfile(fileext = ".diff")
download.file(url = "https://github.com/JanMarvin/diffr2/commit/deff0afe7a2cbaabd42d93fd13a4f8dd0dfabb03.diff", tmp)
diffr2(tmp)
```

## Screenshot from the included shiny example

<img width="800" alt="Screenshot 2022-02-05 at 08 14 56" src="https://user-images.githubusercontent.com/1645626/152632601-a441a4b1-5abc-436b-a3d9-9f82c0e5a201.png">


## License

This package is licensed under the MIT license.
