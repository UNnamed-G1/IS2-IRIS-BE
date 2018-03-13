class Schedule < ApplicationRecord
  has_and_belongs_to_many :users

  validates :start_date, :end_date, presence: true
end
