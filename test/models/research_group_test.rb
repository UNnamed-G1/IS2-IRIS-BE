# == Schema Information
#
# Table name: research_groups
#
#  id                  :bigint(8)        not null, primary key
#  name                :text             not null
#  description         :text             not null
#  strategic_focus     :text             not null
#  research_priorities :text             not null
#  foundation_date     :date
#  classification      :integer
#  date_classification :date
#  url                 :string
#  state               :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class ResearchGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
