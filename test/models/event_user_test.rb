# == Schema Information
#
# Table name: event_users
#
#  type_user_event :integer          default("invitado"), not null
#  user_id         :bigint(8)
#  event_id        :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_event_users_on_event_id  (event_id)
#  index_event_users_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class EventUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
