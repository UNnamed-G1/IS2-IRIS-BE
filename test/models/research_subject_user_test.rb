# == Schema Information
#
# Table name: research_subject_users
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  research_subject_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_research_subject_users_on_research_subject_id  (research_subject_id)
#  index_research_subject_users_on_user_id              (user_id)
#

require 'test_helper'

class ResearchSubjectUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end