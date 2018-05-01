# == Schema Information
#
# Table name: research_subjects
#
#  id         :bigint(8)        not null, primary key
#  name       :string(200)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ResearchSubjectSerializer < ActiveModel::Serializer
  type :reserch_subject

  attributes :id, :name

  has_many :users
  has_many :research_groups
end
