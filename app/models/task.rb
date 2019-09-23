# frozen_string_literal: true

class Task < ApplicationRecord
  attr_accessor :date_range

  belongs_to :user

  validates :title, presence: true
  validates :start, presence: true
  validates :end, presence: true

  def all_day_task?
    start == start.midnight && self.end == self.end.midnight ? true : false
  end
end
