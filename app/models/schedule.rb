class Schedule < ApplicationRecord
  has_and_belongs_to_many :users

  validates :start, :end, presence: true
end
