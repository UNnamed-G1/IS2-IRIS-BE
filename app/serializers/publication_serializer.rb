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
#  publication_type  :integer          not null
#  state             :integer          default("Solicitado"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class PublicationSerializer < ActiveModel::Serializer
  type :publication

  attributes :id, :name, :date, :abstract, :document
  attributes :brief_description, :state

  attribute :publication_type

  has_many :research_groups
  has_many :users

  def document
    return object.document.url
  end

end
