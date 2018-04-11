# == Schema Information
#
# Table name: publication_research_groups
#
#  id                :integer          not null, primary key
#  publication_id    :integer
#  research_group_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_publication_research_groups_on_publication_id     (publication_id)
#  index_publication_research_groups_on_research_group_id  (research_group_id)
#

require 'test_helper'

class PublicationResearchGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
