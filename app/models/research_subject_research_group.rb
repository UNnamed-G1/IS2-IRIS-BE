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

class ResearchSubjectResearchGroup < ApplicationRecord
  belongs_to :research_subject
  belongs_to :research_group
end
