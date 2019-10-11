class SuggestBroadcastJob < ApplicationJob
  queue_as :default

  def perform(suggest, user)
    ActionCable.server.broadcast "suggest_channel_#{suggest.user_id}",
      render_suggest: suggest_render(suggest), status: suggest.status,
      render_working: working_render(suggest.user), admin: user.username
  end

  private

  def suggest_render(suggest)
    ApplicationController.renderer.render(partial: 'static_pages/suggest', locals: { suggest: suggest })
  end

  def working_render(user)
    ApplicationController.renderer.render(partial: 'static_pages/stop', locals: { working: user.workings.last, current_user: user })
  end
end
