R package for creating code differences in JavaScript based on:

[diff2html](https://github.com/rtfpessoa/diff2html)

``` r
library(diffr2)
file1 = tempfile()
writeLines("hello, world!\n", con = file1)
file2 = tempfile()
writeLines(paste0(
"hello world?\nI don't get it\n",
paste0(sample(letters, 65, replace = TRUE), collapse = "")), con = file2)
diffr2(file1, file2, before = "f1", after = "f2")
```
