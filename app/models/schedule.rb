# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  start_date :datetime         not null
#  end_date   :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Schedule < ApplicationRecord
  has_many :schedule_users
  has_many :users, through: :schedule_users

  validates :start_date, :end_date, presence: true
end
