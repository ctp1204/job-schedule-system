# frozen_string_literal: true

class RecurringTask < ApplicationRecord
  belongs_to :user
  enum frequency: { weekly: 0, biweekly: 1, monthly: 2, annually: 3 }

  validates :title, presence: true
  validates :anchor, presence: true
  validates :frequency, presence: true
  validates :color, presence: true

  def schedule
    @schedule ||= begin
      schedule = IceCube::Schedule.new(anchor)
      case frequency
      when "weekly"
        schedule.add_recurrence_rule IceCube::Rule.weekly(1)
      when "biweekly"
        schedule.add_recurrence_rule IceCube::Rule.weekly(2)
      when "monthly"
        schedule.add_recurrence_rule IceCube::Rule.monthly(1)
      when "annually"
        schedule.add_recurrence_rule IceCube::Rule.yearly(1)
      end
      schedule
    end
  end

  def tasks(start_date, end_date)
    start_frequency = start_date ? start_date.to_date : Date.today.last_year
    end_frequency = end_date ? end_date.to_date : Date.today.next_year
    schedule.occurrences_between(start_frequency, end_frequency)
  end

  def all_day_task?
    start == start.midnight && self.end == self.end.midnight
  end
end
