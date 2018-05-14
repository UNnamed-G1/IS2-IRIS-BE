# == Schema Information
#
# Table name: user_research_groups
#
#  joining_date      :date             not null
#  end_joining_date  :date
#  state             :integer          default("Retirado"), not null
#  member_type       :integer          default("Miembro"), not null
#  user_id           :bigint(8)
#  research_group_id :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_user_research_groups_on_research_group_id  (research_group_id)
#  index_user_research_groups_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (research_group_id => research_groups.id)
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class UserResearchGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
