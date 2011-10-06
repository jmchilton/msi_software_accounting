// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
  var enable_javascript = function(index, href) {
    var contains_enable_javascript = href.indexOf("enable_javascript") != -1;
    if(href[0] == '/' && !contains_enable_javascript) {
      href = href + (href.indexOf('?') != -1 ? "&enable_javascript=1" : "?enable_javascript=1");
    }
    //alert("Returning href " + href);
    return href;
  };

  $("a").attr('href', enable_javascript);
  $('<input>').attr({
    type: 'hidden',
    name: 'enable_javascript',
    value: '1'
    }).prependTo("form");
  $(".date-selector").datepicker({ dateFormat: 'yy-mm-dd', changeYear: true, yearRange: 'c-5:c+1' });

});

/*
    ZeroClipboard.setMoviePath( '/swf/ZeroClipboard.swf' );
    $(document).ready(function() {
      var clip = new ZeroClipboard.Client();
      clip.setText("Text To Copy");
      clip.setHandCursor( true );
      clip.glue( 'd_clip_button', 'd_clip_container' );
    });

<div id="d_clip_container" style="position:relative">
   <div id="d_clip_button">Copy to Clipboard</div>
</div>



 */

function follow_row_link(data_table, rowId) {
  var data = data_table.getRowData(rowId);
  var link = data["link"];
  if(link !=  null) {
    window.location = link;
  }
}

function configure_data_table(data_table) {
  // Following doesn't work http://stackoverflow.com/questions/4495453/can-i-change-the-double-click-event-handler-ondblclickrow-for-a-jquery-jqgrid-p/4502667#4502667
  //data_table.jqGrid('setGridParam', { onDblClickRow: function(rowId){
  //  follow_row_link(rowId);
  //} } );
  data_table.dblclick(function(e) {
    var td = e.target;

    var ptr = $(td, data_table[0].rows).closest("tr.jqgrow");
    if($(ptr).length === 0 ){return false;}
    var ri = ptr[0].rowIndex;

    var ci = $.jgrid.getCellIndex(td);

    var rowId = $(ptr).attr("id");

    follow_row_link(data_table, rowId);
    return false;
  });

}