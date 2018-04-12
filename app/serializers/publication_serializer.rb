# == Schema Information
#
# Table name: publications
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  date              :date             not null
#  abstract          :text             not null
#  document          :string
#  brief_description :string(500)      not null
#  type_pub          :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class PublicationSerializer < ActiveModel::Serializer
  type :publication
  
  attributes :id, :name, :date, :abstract, :document
  attributes :brief_description

  attribute :type_pub, key: :publication_type

  has_many :research_groups
  has_many :users
end
