$(document).ready(function() {
  /*ステータスが完了のタスクをグレーに変更*/
  $(".status").each(function() {
    if($(this).text() == "完了") {
      $(this).parent().css("background-color", "lightgray");
    };
  });
 });
