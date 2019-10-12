# frozen_string_literal: true

module Admin
  class WorkingsController < BaseController
    before_action :load_working, only: :update

    def index
      params[:working_date] = Time.now unless params[:working_date]
      @workings = Working.all.select{ |w| w.checkin.to_date == params[:working_date].to_date }
      respond_to do |format|
        format.html
        format.js
      end
    end

    private

    def load_working
      @working = Working.find_by id: params[:id]
      return if @working

      redirect_to admin_root_path, danger: t(".suggest_not")
    end
  end
end
