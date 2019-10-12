class WorkingBroadcastJob < ApplicationJob
  queue_as :default

  def perform(working, checkin)
    ActionCable.server.broadcast 'working_channel',  render_working: working_render(working),
      to_date: Time.now.to_date.to_s, checkin: checkin, working_id: working.id
  end

  private

  def working_render(working)
    ApplicationController.renderer.render(partial: 'admin/workings/working', locals: { working: working })
  end
end
