$(document).ready(function() {
  $("#select_date").change(function(){
    $.ajax({
      type: "get",
      url: "/admin/workings",
      dataType: "script",
      data: { working_date: $(this).val() }
    });
  });

  $("#menu-toggle").click(function(e) {
    e.preventDefault();
    $("#wrapper").toggleClass("toggled");
  });
});
