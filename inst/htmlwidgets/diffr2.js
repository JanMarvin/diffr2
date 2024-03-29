HTMLWidgets.widget({
  name: 'diffr2',
  type: 'output',

  factory: function(el, width, height) {

    return {
      renderValue: function(x) {
        document.body.style.overflow = "auto";

        /*
          console.log(x);
          console.log(el);
        */

        // either needed?
        //document.addEventListener('DOMContentLoaded', function () {
        //$(funtion() {
        var targetElement = document.getElementById(x.divname);
        var configuration = {
          synchronisedScroll: x.synchronisedScroll,
          stickyFileHeaders: x.stickyFileHeaders,
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
          colorScheme: x.colorScheme,
        };
        var diff2htmlUi = new Diff2HtmlUI(targetElement, x.diffString, configuration);
        diff2htmlUi.draw();

        // FIXME not required?
        // diff2htmlUi.highlightCode();
      },

      // empty
      resize: function(width, height) {}

    };
  }
});
