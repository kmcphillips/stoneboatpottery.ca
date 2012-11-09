$(document).ready(function($) {
  init_facebox();
  $('#upload input.submit').attr("disabled", false);
})



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

function init_facebox()
{
  $('a[rel=facebox]').facebox({
    closeImage    : '/images/template/closelabel.gif',
    loadingImage  : '/images/template/throbber.gif',
    nextImage     : '/images/template/next.png',
    previousImage : '/images/template/prev.png'
  });
}

function clear_upload_field()
{
  $('#image_image').val("");
}

function upload_before()
{
  $('#upload img.throbber').show();
  $('#upload input.submit').attr("disabled", true);
}

function upload_after()
{
  $('#upload').overlay().close();
  $('#upload img.throbber').hide();
  $('#upload input.submit').attr("disabled", false);
  clear_upload_field();
}
