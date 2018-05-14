# == Schema Information
#
# Table name: publications
#
#  id                :bigint(8)        not null, primary key
#  name              :text             not null
#  date              :date             not null
#  abstract          :text             not null
#  document          :text
#  brief_description :string(500)      not null
#  type_pub          :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class PublicationSerializer < ActiveModel::Serializer
  type :publication

  attributes :id, :name, :date, :abstract, :document
  attributes :brief_description

  attribute :publication_type

  has_many :research_groups
  has_many :users

  def document
    return object.document.url
  end

end
