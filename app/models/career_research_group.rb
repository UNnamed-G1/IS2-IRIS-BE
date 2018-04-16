# == Schema Information
#
# Table name: career_research_groups
#
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
# Foreign Keys
#
#  fk_rails_...  (career_id => careers.id)
#  fk_rails_...  (research_group_id => research_groups.id)
#

class CareerResearchGroup < ApplicationRecord
  belongs_to :research_group
  belongs_to :career
end
