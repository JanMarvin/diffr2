
# requires curl

dir.create("inst/htmlwidgets/lib/diff2html")

github_min_css <- "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.13.1/styles/github.min.css"
curl::curl_download(github_min_css, "inst/htmlwidgets/lib/diff2html/github.min.css")

diff2html_min_css <- "https://cdn.jsdelivr.net/npm/diff2html/bundles/css/diff2html.min.css"
curl::curl_download(diff2html_min_css, "inst/htmlwidgets/lib/diff2html/diff2html.min.css")

diff2html_ui_min_js <- "https://cdn.jsdelivr.net/npm/diff2html/bundles/js/diff2html-ui.min.js"
curl::curl_download(diff2html_ui_min_js, "inst/htmlwidgets/lib/diff2html/diff2html-ui.min.js")

# jquery_min_js <- "https://code.jquery.com/jquery-3.6.0.min.js"
# curl::curl_download(jquery_min_js, "inst/htmlwidgets/lib/diff2html/jquery.min.js")


# dir.create("inst/htmlwidgets/lib/difflib")
#
# difflib_js <- "https://github.com/qiao/difflib.js/raw/master/dist/difflib-browser.js"
# curl::curl_download(difflib_js, "inst/htmlwidgets/lib/difflib/difflib.js")


dir.create("inst/js")

diff_js <- "https://cdnjs.cloudflare.com/ajax/libs/jsdiff/5.0.0/diff.min.js"
curl::curl_download(diff_js, "inst/js/diff.min.js")

