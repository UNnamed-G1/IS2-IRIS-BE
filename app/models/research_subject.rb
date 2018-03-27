# == Schema Information
#
# Table name: research_subjects
#
#  id         :integer          not null, primary key
#  name       :string(200)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ResearchSubject < ApplicationRecord
  has_many :research_subject_users
  has_many :users, through: :research_subject_users

  has_many :research_subject_research_groups
  has_many :research_groups, through: :research_subject_research_groups

  validates :name, presence: true
  validates :name, length: { maximum: 200, too_long: "Se permiten máximo %´{count} caracteres" }
end
