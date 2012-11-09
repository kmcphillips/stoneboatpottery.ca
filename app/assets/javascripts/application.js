//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.remotipart
//= require_tree .

$(document).ajaxError(function(event, xhr, ajaxOptions, thrownError) {
  if(xhr.statusText != "canceled") // I think this is caused by the 'remotipart' gem.
  {
    alert("There was an error processing your request. If it continues, please contact the administrator. " + thrownError);
  }
});
