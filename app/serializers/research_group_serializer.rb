class ResearchGroupSerializer < ActiveModel::Serializer
  type :research_group
  
  attributes :id, :name, :description, :strategic_focus
  attributes :research_priorities, :foundation_date, :classification
  attributes :date_classification, :url

  has_many :research_subjects
  has_many :publications
  has_many :careers
  has_many :events
  has_many :user_research_groups, key: :members
  has_one :photo

end
