NotifySuggestListener = (data) ->
  if data['status'] == "rejected"
    $('#suggest_status').html(data['render_suggest'])
    toastr.error(data['admin'] + ' rejected your suggest')
  else
    $('#suggest_status').remove()
    $('#stop_status').html(data['render_working'])
    toastr.success(data['admin'] + ' approved your suggest')
  return

App.suggests = App.cable.subscriptions.create "SuggestsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    NotifySuggestListener(data)
