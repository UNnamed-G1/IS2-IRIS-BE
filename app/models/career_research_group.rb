# == Schema Information
#
# Table name: career_research_groups
#
#  id                :integer          not null, primary key
#  career_id         :integer
#  research_group_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_career_research_groups_on_career_id          (career_id)
#  index_career_research_groups_on_research_group_id  (research_group_id)
#

class CareerResearchGroup < ApplicationRecord
  belongs_to :research_group
  belongs_to :career
end
