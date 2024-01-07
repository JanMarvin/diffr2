
#' create a diff as character string
#' @description creates a diff of two text files. Based on jsdiff (BSD)
#' javascript library by Kevin Decker. If character vectors are supplied, a
#' diff will be created from them as well.
#'
#' @examples
#'  create_diff("foo\nbar", "foo\nbaz")
#'
#' @param oldFile old
#' @param newFile new
#' @importFrom V8 v8
#' @export
create_diff <- function(oldFile = NULL, newFile = NULL) {

  if (!is.null(oldFile) & !is.null(newFile)) {
    if (!file.exists(oldFile) || !file.exists(newFile)) {
      old <- oldFile
      oldFile <- "file"
      new <- newFile
      newFile <- "file"
    } else {
      old <- paste(readLines(oldFile), collapse = "\n")
      oldFile <- basename(oldFile)
      new <- paste(readLines(newFile), collapse = "\n")
      newFile <- basename(newFile)
    }
  } else {
    stop("oldFile and/or newFile not found")
  }

  ct <- V8::v8()
  ct$source(system.file("js/jsdiff-5.1.0/diff.min.js", package = "diffr2"))

  z <- ct$call("function(oldFile, newFile, oldText, newText) {return Diff.createTwoFilesPatch(oldFile, newFile, oldText, newText);}",
               oldFile, newFile, old, new)
  z
}

#' @title View text file differences
#' @description Shows diff based on the diff2html (MIT) js library by Rodrigo Fernandes. Most of the option descriptions are from their github page.
#' @param oldFile Your reference file (the old file). Either a path or a character.
#' @param newFile Your comparison file (the new file). Either a path or a character.
#' @param diff Alternatively you can provide your diff file. Either a path or a character. If provided, it overrides oldFile & newFile diff.
#' @param width for \code{\link{createWidget}}
#' @param height for \code{\link{createWidget}}
#' @param synchronisedScroll scroll both panes in side-by-side mode: TRUE or FALSE, default is TRUE
#' @param stickyFileHeaders make file headers sticky: TRUE or FALSE, default is TRUE
#' @param highlight syntax highlight the code on the diff: TRUE or FALSE, default is TRUE
#' @param fileListToggle allow the file summary list to be toggled: TRUE or FALSE, default is TRUE
#' @param fileListStartVisible choose if the file summary list starts visible: TRUE or FALSE, default is FALSE
#' @param fileContentToggle allow each file contents to be toggled: TRUE or FALSE, default is TRUE
#' @param outputFormat the format of the output data: 'line-by-line' or 'side-by-side', default is 'line-by-line'
#' @param drawFileList show a file list before the diff: TRUE or FALSE, default is TRUE
#' @param diffMaxChanges number of changed lines after which a file diff is deemed as too big and not displayed, default is undefined
#' @param diffMaxLineLength number of characters in a diff line after which a file diff is deemed as too big and not displayed, default is undefined
#' @param matching matching level: 'lines' for matching lines, 'words' for matching lines and words or 'none', default is none
#' @param matchWordsThreshold similarity threshold for word matching, default is 0.25
#' @param maxLineLengthHighlight only perform diff changes highlight if lines are smaller than this, default is 10000
#' @param diffStyle show differences level in each line: 'word' or 'char', default is 'word'
#' @param renderNothingWhenEmpty render nothing if the diff shows no change in its comparison: TRUE or FALSE, default is FALSE
#' @param matchingMaxComparisons perform at most this much comparisons for line matching a block of changes, default is 2500
#' @param maxLineSizeInBlockForComparison maximum number os characters of the bigger line in a block to apply comparison, default is 200
#' @param divname the default is `'htmlwidget_container'`, for shiny it must match the `output$divname`
#' @param colorScheme color scheme to use for the diff, default is 'auto'. Possible values are light, dark, and auto which will use the browser's preferred color scheme.
#' @importFrom htmlwidgets createWidget
#' @export
#' @examples
#' library(diffr2)
#' file1 = tempfile()
#' writeLines("hello, world!\n", con = file1)
#' file2 = tempfile()
#' writeLines(paste0(
#' "hello world?\nI don't get it\n",
#' paste0(sample(letters, 65, replace = TRUE), collapse = "")), con = file2)
#' diffr2(file1, file2)
diffr2 <- function(
    oldFile = NULL,
    newFile = NULL,
    diff = NULL,
    width = NULL,
    height = NULL,
    synchronisedScroll = TRUE,
    stickyFileHeaders = TRUE,
    highlight = TRUE,
    fileListToggle = TRUE,
    fileListStartVisible = FALSE,
    fileContentToggle = TRUE,
    outputFormat = "line-by-line",
    drawFileList = TRUE,
    diffMaxChanges = NA,
    diffMaxLineLength = NA,
    matching = "none",
    matchWordsThreshold = 0.25,
    maxLineLengthHighlight = 10000,
    diffStyle = "word",
    renderNothingWhenEmpty = FALSE,
    matchingMaxComparisons = 2500,
    maxLineSizeInBlockForComparison = 200,
    divname = 'htmlwidget_container',
    colorScheme = "auto"
) {

  if (is.null(oldFile) && is.null(newFile) && is.null(diff))
    stop("no input provided")

  if (is.null(newFile) & is.null(diff))
    diff <- oldFile # override for lazy programmer

  # override if diff is provided (could be from git diff etc.)
  if (!is.null(diff)) {
    # support reading diff from file
    if (file.exists(diff)) diff <- paste(readLines(diff), collapse = "\n")
  } else {
    diff <- create_diff(oldFile, newFile)
  }

  # forward options using x
  x <- list(
    diffString = diff,
    synchronisedScroll = synchronisedScroll,
    stickyFileHeaders = stickyFileHeaders,
    highlight = highlight,
    fileListToggle = fileListToggle,
    fileListStartVisible = fileListStartVisible,
    outputFormat = outputFormat,
    drawFileList = drawFileList,
    diffMaxChanges = diffMaxChanges,
    diffMaxLineLength = diffMaxLineLength,
    matching = matching,
    matchWordsThreshold = matchWordsThreshold,
    maxLineLengthHighlight = maxLineLengthHighlight,
    diffStyle = diffStyle,
    renderNothingWhenEmpty = renderNothingWhenEmpty,
    matchingMaxComparisons = as.character(matchingMaxComparisons),
    maxLineSizeInBlockForComparison = as.character(maxLineSizeInBlockForComparison),
    divname = divname,
    colorScheme = as.character(colorScheme)
  )

  # create the widget
  createWidget(
    name = 'diffr2',
    x = x,
    width = width,
    height = height,
    package = 'diffr2'
  )
}

#' Wrapper functions for using \pkg{diffr2} in \pkg{shiny}
#'
#' Use \code{diffr2Output()} to create a UI element, and \code{renderDiffr2()}
#' to render the diffr2 widget.
#' @inheritParams htmlwidgets::shinyWidgetOutput
#' @param width,height the width and height of the diffr2 widget
#' @rdname diffr2-shiny
#' @export
diffr2Output <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "diffr2", width, height, "diffr2")
}
# use expr description from htmlwidgets to avoid bad inherit params code
#' @details When calling \code{renderDiffr2()} make sure that \code{divname}
#' matches the selected shiny output name. The div name is used to attach the
#' diff2html output. Otherwise the canvas will be blank.
#' @param expr An expression that generates an HTML widget (or a
#'   \href{https://rstudio.github.io/promises/}{promise} of an HTML widget).
#' @rdname diffr2-shiny
#' @export
renderDiffr2 <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, diffr2Output, env, quoted = TRUE)
}
