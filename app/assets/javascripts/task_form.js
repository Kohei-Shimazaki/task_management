$(document).ready(function() {
  $(".status").each(function() {
    if($(this).text() == "完了") {
      $(this).parent().css("background-color", "lightgray");
    };
  });
 });
