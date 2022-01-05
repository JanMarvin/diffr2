
#' create the diff as character string
#' @description shows the diff of two text files. Based on jsdiff (BSD) js library by Kevin Decker
#'
#' @param oldFile old
#' @param newFile new
#' @importFrom V8 v8
#' @export
create_diff <- function(oldFile = NULL, newFile = NULL) {

  if (!is.null(oldFile) & !is.null(newFile)) {
    if (!file.exists(oldFile) || !file.exists(newFile)) {
      old <- oldFile
      new <- newFile
    } else {
      old <- paste(readLines(oldFile), collapse = "\n")
      new <- paste(readLines(newFile), collapse = "\n")
    }
  } else {
    stop("oldFile and/or newFile not found")
  }

  ct <- V8::v8()
  ct$source(system.file("js/jsdiff-5.0.0/diff.min.js", package = "diffr2"))

  z <- ct$call("function(oldText, newText) {return Diff.createTwoFilesPatch(\"file\", \"file\", oldText, newText);}",
               old, new)
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
    maxLineSizeInBlockForComparison = 200
) {

  if (is.null(oldFile) & is.null(newFile) & is.null(diff))
    stop("no input provided")

  if (is.null(newFile) & is.null(diff))
    diff <- oldFile # override for lazy programmer

  if (!is.null(oldFile) & !is.null(newFile))
    if (!file.exists(oldFile) || !file.exists(newFile))
      stop("oldFile and/or newFile not found")

  # override if diff is provided (could be from git diff etc.)
  if (!is.null(diff)) {
    # support reading diff from file
    if (file.exists(diff)) diff <- paste(readLines(diff), collapse = "\n")
  } else {
    diff <- create_diff(oldFile, newFile)
  }

  # create true/false for js
  to_lower_js <- function(x) tolower(as.character(x))

  # forward options using x
  x <- list(
    diffString = diff,
    synchronisedScroll = to_lower_js(synchronisedScroll),
    highlight = to_lower_js(highlight),
    fileListToggle = to_lower_js(fileListToggle),
    fileListStartVisible = to_lower_js(fileListStartVisible),
    outputFormat = outputFormat,
    drawFileList = to_lower_js(drawFileList),
    diffMaxChanges = diffMaxChanges,
    diffMaxLineLength = diffMaxLineLength,
    matching = matching,
    matchWordsThreshold = matchWordsThreshold,
    maxLineLengthHighlight = maxLineLengthHighlight,
    diffStyle = diffStyle,
    renderNothingWhenEmpty = to_lower_js(renderNothingWhenEmpty),
    matchingMaxComparisons = as.character(matchingMaxComparisons),
    maxLineSizeInBlockForComparison = as.character(maxLineSizeInBlockForComparison)
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
