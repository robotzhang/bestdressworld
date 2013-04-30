// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs

$(document).ready(function() {
  function set_cate_panel_position() {
    $('#cate-panel').css({
        left: $('.nav-bar .find a').offset().left
    });
    return $('#cate-panel');
  }
  set_cate_panel_position().show();
  $('.nav-bar .find, #cate-panel').mouseover(function(){
    set_cate_panel_position().show();
  }).mouseout(function() {
    if ($('#cate-panel').attr('show') == 'true') {
      return false;
    }
    $('#cate-panel').hide();
  });
});