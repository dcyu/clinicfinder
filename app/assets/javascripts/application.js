// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require list
//= require list.pagination.js
//= require jquery_nested_form
//= require autocomplete-rails
//= require bootstrap
//= require_tree .


$(function() {
  $( ".sort" ).click(function( event ) {
    event.preventDefault();
  });
});

window.NestedFormEvents.prototype.insertFields = function(content, assoc, link) {
  var $tr = $(link).closest('tr');
  return $(content).insertBefore($tr);
}

// geolocation
function getGeoLocation() {
  navigator.geolocation.getCurrentPosition(setGeoCookie);
}

function setGeoCookie(position) {
  var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
  document.cookie = "lat_lng=" + escape(cookie_val);
}