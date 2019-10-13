# frozen_string_literal: true

class Holiday < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :color, presence: true
  scope :newest, -> { order created_at: :desc }
  attr_accessor :date_range

  def all_day_holiday?
    start == start.midnight && self.end == self.end.midnight
  end
end
