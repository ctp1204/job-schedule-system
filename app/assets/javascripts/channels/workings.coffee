NotifyWorkingListener = (data) ->
  if $("#select_date").val() == data['to_date']
    if data['checkin'] == 1
      $('#list_working').prepend(data['render_working'])
    else
      $('#working' + data['working_id']).replaceWith data['render_working']

App.workings = App.cable.subscriptions.create "WorkingsChannel",
  received: (data) ->
    NotifyWorkingListener(data)
