# frozen_string_literal: true

module Admin
  class SuggestsController < BaseController
    before_action :load_suggest, only: :update

    def index
      @users = User.includes(:suggests).newest.select { |u| u.suggests.count.positive? }
    end

    def edit; end

    def update
      @suggest.status = params[:value]
      @suggest.save
      @suggest.user.open! if @suggest.approved?
      @notification = @suggest.notifications.find_by(user_id: current_user)
      SuggestBroadcastJob.perform_later(@suggest, current_user)
      SendEmailSuggestJob.set(wait: 10.seconds).perform_later(@suggest)
      call_api_slack @suggest
      respond_to do |format|
        format.js
      end
    end

    private

    def load_suggest
      @suggest = Suggest.find_by id: params[:id]
      return if @suggest

      redirect_to admin_root_path, danger: t(".suggest_not")
    end
  end
end
