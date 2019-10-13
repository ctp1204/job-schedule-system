# frozen_string_literal: true

date_format = task.all_day_task? ? "%Y-%m-%d" : "%Y-%m-%dT%H:%M:%S"

json.id task.id
json.title task.title
json.start task.start.strftime(date_format)
json.end task.end.strftime(date_format)
json.progress task.progress

json.color task.color unless task.color.blank?
json.allDay task.all_day_task?

json.update_url task_path(task, method: :patch)

json.edit_url edit_task_path(task)
