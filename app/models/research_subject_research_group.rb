class ResearchSubjectResearchGroup < ApplicationRecord
  belongs_to :research_subject
  belongs_to :research_group
end
