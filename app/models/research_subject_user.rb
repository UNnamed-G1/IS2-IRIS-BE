class ResearchSubjectUser < ApplicationRecord
  belongs_to :user
  belongs_to :research_subject
end
