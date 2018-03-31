class ResearchSubjectSerializer < ActiveModel::Serializer
  type :reserch_subject

  attributes :id, :name

  has_many :users
  has_many :research_groups
end
