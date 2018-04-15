# == Schema Information
#
# Table name: research_subject_research_groups
#
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
# Foreign Keys
#
#  fk_rails_...  (research_group_id => research_groups.id)
#  fk_rails_...  (research_subject_id => research_subjects.id)
#

class ResearchSubjectResearchGroup < ApplicationRecord
  belongs_to :research_subject
  belongs_to :research_group
end
