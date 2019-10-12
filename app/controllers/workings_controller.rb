# frozen_string_literal: true

class WorkingsController < ApplicationController
  before_action :load_working, only: :update

  def create
    working_params = { checkin: Time.now, checkout: Time.parse("17:00", Time.now) }
    working_params.merge!(content: t(".content")) if working_params[:checkin] > Time.parse("08:00:59", Time.now)
    @working = current_user.workings.build working_params
    @working.save
    WorkingBroadcastJob.perform_later(@working, 1)
    respond_to do |format|
      format.js
    end
  end

  def update
    current_user.close!
    @working.update checkout: Time.now
    WorkingBroadcastJob.perform_later(@working, 0)
  rescue StandardError
    respond_to do |format|
      format.js
    end
  end

  private

  def load_working
    @working = Working.find_by id: params[:id]
  end
end
