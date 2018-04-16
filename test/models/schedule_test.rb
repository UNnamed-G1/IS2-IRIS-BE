# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  start_hour :integer          not null
#  duration   :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
