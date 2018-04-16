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

require 'test_helper'

class ScheduleUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
