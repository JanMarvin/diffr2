# diffr2 for nice diffs

R package for creating code differences with JavaScript based on:

[diff2html](https://github.com/rtfpessoa/diff2html) and [jsdiff](https://github.com/kpdecker/jsdiff)

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
