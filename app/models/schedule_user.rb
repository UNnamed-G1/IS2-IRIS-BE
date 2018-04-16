# == Schema Information
#
# Table name: schedule_users
#
#  user_id     :integer
#  schedule_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_schedule_users_on_schedule_id  (schedule_id)
#  index_schedule_users_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (schedule_id => schedules.id)
#  fk_rails_...  (user_id => users.id)
#

class ScheduleUser < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
end
