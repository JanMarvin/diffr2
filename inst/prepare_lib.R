
# requires curl

# js and css files for htmlwidget

unlink("inst/htmlwidgets/lib", recursive = TRUE)
dir.create("inst/htmlwidgets/lib")

highlightjs_ver <- "11.9.0"
diff2html_ver <- "3.4.47"
jsdiff_ver <- "5.2.0"


#### highlight.js ####
highlightjs <- sprintf("inst/htmlwidgets/lib/highlight.js-%s", highlightjs_ver)
dir.create(highlightjs)

github_min_css <- sprintf("https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@%s/build/styles/github.min.css", highlightjs_ver)
curl::curl_download(github_min_css, paste0(highlightjs, "/github.min.css"))

github_dark_min_css <- sprintf("https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@%s/build/styles/github-dark.min.css", highlightjs_ver)
curl::curl_download(github_dark_min_css, paste0(highlightjs, "/github-dark.min.css"))

hightlightjs_lic <- sprintf("https://cdn.jsdelivr.net/npm/highlight.js@%s/LICENSE", highlightjs_ver)
curl::curl_download(hightlightjs_lic, paste0(highlightjs, "/LICENSE"))


#### diff2html ####
diff2html <- sprintf("inst/htmlwidgets/lib/diff2html-%s", diff2html_ver)
dir.create(diff2html)

diff2html_min_css <- sprintf("https://cdn.jsdelivr.net/npm/diff2html@%s/bundles/css/diff2html.min.css", diff2html_ver)
curl::curl_download(diff2html_min_css, paste0(diff2html, "/diff2html.min.css"))

diff2html_ui_min_js <- sprintf("https://cdn.jsdelivr.net/npm/diff2html@%s/bundles/js/diff2html-ui.min.js", diff2html_ver)
curl::curl_download(diff2html_ui_min_js, paste0(diff2html, "/diff2html-ui.min.js"))

diff2html_lic <- sprintf("https://cdn.jsdelivr.net/npm/diff2html@%s/LICENSE.md", diff2html_ver)
curl::curl_download(diff2html_lic, paste0(diff2html, "/LICENSE"))

unlink("inst/js", recursive = TRUE)
dir.create("inst/js")

#### jsdiff ####
jsdiff <- sprintf("inst/js/jsdiff-%s", jsdiff_ver)
dir.create(jsdiff)

diff_js <- sprintf("https://cdn.jsdelivr.net/npm/diff@%s/dist/diff.js", jsdiff_ver)
curl::curl_download(diff_js, paste0(jsdiff, "/diff.min.js"))

jsdiff_lic <- sprintf("https://cdn.jsdelivr.net/npm/diff@%s/LICENSE", jsdiff_ver)
curl::curl_download(jsdiff_lic, paste0(jsdiff, "/LICENSE"))

## create diffr2.yaml
diffr2_yaml <- sprintf(
"# (uncomment to add a dependency)
dependencies:
  - name: highlight.js
    version: %s
    src: \"htmlwidgets/lib/highlight.js-%s\"
    stylesheet:
      - link: github.min.css
        media: \"screen and (prefers-color-scheme: light)\"
      - link: github-dark.min.css
        media: \"screen and (prefers-color-scheme: dark)\"
  - name: diff2html
    version: %s
    src: \"htmlwidgets/lib/diff2html-%s\"
    script:
      - diff2html-ui.min.js
    stylesheet:
      - link: diff2html.min.css",
highlightjs_ver, highlightjs_ver,
diff2html_ver, diff2html_ver
)
writeLines(diffr2_yaml, "inst/htmlwidgets/diffr2.yaml")

## update jsdiff
r_diffr2 <- gsub(
  pattern = "js/jsdiff-*.diff.min.js",
  replacement = sprintf("js/jsdiff-%s.diff.min.js", jsdiff_ver),
  x = readLines("R/diffr2.R")
)
writeLines(r_diffr2, "R/diffr2.R")
