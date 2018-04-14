# == Schema Information
#
# Table name: research_subject_research_groups
#
#  id                  :integer          not null, primary key
#  research_subject_id :integer
#  research_group_id   :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_research_subject_research_groups_on_research_group_id    (research_group_id)
#  index_research_subject_research_groups_on_research_subject_id  (research_subject_id)
#

require 'test_helper'

class ResearchSubjectResearchGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
