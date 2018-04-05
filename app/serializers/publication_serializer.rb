class PublicationSerializer < ActiveModel::Serializer
  type :publication
  
  attributes :id, :name, :date, :abstract, :url
  attributes :brief_description

  attribute :type_pub, key: :publication_type

  has_many :research_groups
  has_many :users
end
