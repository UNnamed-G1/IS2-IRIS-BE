# == Schema Information
#
# Table name: research_subject_users
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  research_subject_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ResearchSubjectUser < ApplicationRecord
  belongs_to :research_subject
  belongs_to :user
end
