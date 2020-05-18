$(document).ready(function() {
    $("#task_status").change(function() {
      var status = $(this).val();
      $('.status').text($(this).val());
    });
    $("#task_status").change(function() {
      $('.add').show();
    });
    $(".add").click(function() {
      $(".form_block").clone(true).insertAfter(".form_block");
    });
 });
