NotifySuggestListener = (data) ->
  if data['status'] == "rejected"
    $('#suggest_status').html(data['render_suggest'])
    toastr.error(data['admin'] + ' rejected your suggest')
  else
    $('#suggest_status').remove()
    $('#stop_status').html(data['render_working'])
    toastr.success(data['admin'] + ' approved your suggest')

App.suggests = App.cable.subscriptions.create "SuggestsChannel",
  received: (data) ->
    NotifySuggestListener(data)
