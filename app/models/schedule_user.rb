# == Schema Information
#
# Table name: schedule_users
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  schedule_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ScheduleUser < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
end
