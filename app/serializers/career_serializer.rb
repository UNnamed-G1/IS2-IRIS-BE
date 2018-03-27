class CareerSerializer < ActiveModel::Serializer
  type :career
  
  attributes :id, :name, :snies_code, :degree_type

  has_many :users
  has_many :research_groups
  belongs_to :department
end
