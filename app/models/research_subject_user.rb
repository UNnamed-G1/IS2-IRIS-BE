class ResearchSubjectUser < ApplicationRecord
  belongs_to :research_subject
  belongs_to :user
end
