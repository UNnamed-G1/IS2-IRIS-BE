# == Schema Information
#
# Table name: research_groups
#
#  id                  :integer          not null, primary key
#  name                :text             not null
#  description         :text             not null
#  strategic_focus     :text             not null
#  research_priorities :text             not null
#  foundation_date     :date             not null
#  classification      :integer          not null
#  date_classification :date             not null
#  url                 :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class ResearchGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
