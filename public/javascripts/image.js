function show_upload() {
  $("#upload").overlay({
    top: 272,
    expose: {
      color: '#000000',
      loadSpeed: 100,
      opacity: 0.3
    },
    api: true
  }).load();
}

$(document).ready(function($) {
  $('a[rel*=facebox]').facebox()
}) 
