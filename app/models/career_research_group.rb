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

class CareerResearchGroup < ApplicationRecord
  belongs_to :research_group
  belongs_to :career
end
