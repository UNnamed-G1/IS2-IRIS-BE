# == Schema Information
#
# Table name: research_subject_users
#
#  user_id             :bigint(8)
#  research_subject_id :bigint(8)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_research_subject_users_on_research_subject_id  (research_subject_id)
#  index_research_subject_users_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (research_subject_id => research_subjects.id)
#  fk_rails_...  (user_id => users.id)
#

class ResearchSubjectUser < ApplicationRecord
  belongs_to :research_subject
  belongs_to :user
end
