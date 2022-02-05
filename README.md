# diffr2 for nice diffs

R package for creating code differences with JavaScript based on:

[diff2html](https://github.com/rtfpessoa/diff2html) and [jsdiff](https://github.com/kpdecker/jsdiff)

## example code

``` r
library(diffr2)

file1 = tempfile()
writeLines("hello, world!\n", con = file1)
file2 = tempfile()
writeLines(paste0(
"hello world?\nI don't get it\n",
paste0(sample(letters, 65, replace = TRUE), collapse = "")), con = file2)

# side by side comparisson
diffr2(file1, file2)

# raw diff
message(create_diff(file1, file2))

# git diff

git_head <- paste(gert::git_diff_patch(ref = "HEAD^", repo = "."), collapse = "\n")
diffr2(diff = git_head, outputFormat = "side-by-side")
```

## Screenshot from the included shiny example

<img width="800" alt="Screenshot 2022-02-05 at 08 14 56" src="https://user-images.githubusercontent.com/1645626/152632601-a441a4b1-5abc-436b-a3d9-9f82c0e5a201.png">
