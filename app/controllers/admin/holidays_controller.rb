# frozen_string_literal: true

module Admin
  class HolidaysController < BaseController
    def index
      @holidays = Holiday.all.newest
    end

    def create
      @holiday = current_user.holidays.build holiday_params
      @holiday.save
      respond_to do |format|
        format.js
      end
    end

    private

    def holiday_params
      params.require(:holiday).permit :title, :start, :end, :color
    end
  end
end
