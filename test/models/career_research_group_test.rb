# == Schema Information
#
# Table name: career_research_groups
#
#  career_id         :bigint(8)
#  research_group_id :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_career_research_groups_on_career_id          (career_id)
#  index_career_research_groups_on_research_group_id  (research_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (career_id => careers.id)
#  fk_rails_...  (research_group_id => research_groups.id)
#

require 'test_helper'

class CareerResearchGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
