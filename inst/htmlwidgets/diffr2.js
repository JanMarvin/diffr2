HTMLWidgets.widget({
  name: 'diffr2',
  type: 'output',

  factory: function(el, width, height) {

    return {
      renderValue: function(x) {
        // document.body.style.overflow = "auto";

        /*
          console.log(x);
          console.log(el);
        */

        // either needed?
        //document.addEventListener('DOMContentLoaded', function () {
        //$(funtion() {
        var targetElement = document.getElementById('htmlwidget_container');
        var configuration = {
          synchronisedScroll: x.synchronisedScroll,
          highlight: x.highlight,
          fileListToggle: x.fileListToggle,
          fileListStartVisible: x.fileListStartVisible,
          outputFormat: x.outputFormat,
          drawFileList: x.drawFileList,
          diffMaxLineLength: x.diffMaxLineLength,
          matching: x.matching,
          matchWordsThreshold: x.matchWordsThreshold,
          maxLineLengthHighlight: x.maxLineLengthHighlight,
          diffStyle: x.diffStyle,
          renderNothingWhenEmpty: x.renderNothingWhenEmpty,
          matchingMaxComparisons: x.matchingMaxComparisons,
          maxLineSizeInBlockForComparison: x.maxLineSizeInBlockForComparison,
        };
        var diff2htmlUi = new Diff2HtmlUI(targetElement, x.diffString, configuration);
        diff2htmlUi.draw();
        diff2htmlUi.highlightCode();
      },

    };
  }
});
