// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
        var enable_javascript = function(index, href) {
            var contains_enable_javascript = href.indexOf("enable_javascript") != -1;
            if(!contains_enable_javascript) {
                return href + (href.indexOf('?') != -1 ? "&enable_javascript=1" : "?enable_javascript=1");
            } else {
                return href;
            }
        };
        $("a").attr('href', enable_javascript);
        $("form").attr('action', enable_javascript);
  
    });