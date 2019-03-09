//= require jquery
//= require jquery_ujs
//= require activestorage
//= require turbolinks
//= require popper
//= require bootstrap
//= require jcrop
//= require jquery-ui/core
//= require jquery-ui/widgets/sortable
//= require html.sortable
//= require sortable_simulate
//= require simplemde.min
//= require inline-attachment
//= require codemirror-4.inline-attachment
//= require dropzone

$(document).on("turbolinks:load", function() {
  $('#form-modal-save-btn').click(function() {
    $('#form-modal-body').find('form').submit();
  });

  toastr.options = {
    "closeButton": false,
    "debug": false,
    "newestOnTop": false,
    "progressBar": false,
    "positionClass": "toast-top-center",
    "preventDuplicates": false,
    "onclick": null,
    "showDuration": "100",
    "hideDuration": "1000",
    "timeOut": "1000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  }
  
  $('.show-order').click(function(){
    location.reload();
  });
  
  $('[data-toggle="lightbox"]').click(function(event){
    event.preventDefault();
    $(this).ekkoLightbox();
  });
})
