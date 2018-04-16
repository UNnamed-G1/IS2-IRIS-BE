# == Schema Information
#
# Table name: publications
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
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

  attribute :type_pub, key: :publication_type

  has_many :research_groups
  has_many :users

  def type_pub
    return object.type_pub.capitalize
  end
  
  def document

    if object.document.url
      return Base64.strict_encode64(File.read("#{Rails.root}/public/#{object.document.url}"))
    else
      return ''
    end
  end
end
