class Schedule < ApplicationRecord
  has_many :schedule_users
  has_many :users, through: :schedule_users

  validates :start_date, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha de inicio") } }
  validates :end_date, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha de inicio") } }
end
