$(document).ready(function() {
  $('.js-example-basic-single').select2({
    placeholder: "Select a channel",
    allowClear: true,
    tags: true
  });

  $('#search').autocomplete({
      source: '/auto_fill_text/autocomplete',
      select: function(event, ui){
        $('#search').val(ui.item.value);
        $(this).closest('form').trigger('submit');
      }
  });

  $("#search_user").autocomplete({
    source: '/auto_fill_text/getusers',
    focus: function(event, ui) {
      // prevent autocomplete from updating the textbox
      event.preventDefault();
      // manually update the textbox
      $(this).val(ui.item.label);
    },
    select: function(event, ui) {
      // prevent autocomplete from updating the textbox
      event.preventDefault();
      // manually update the textbox and hidden field
      $(this).val(ui.item.label);
      $("#user_id").val(ui.item.value);
    }
  });
});
