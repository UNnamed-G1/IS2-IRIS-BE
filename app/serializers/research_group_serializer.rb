# == Schema Information
#
# Table name: research_groups
#
#  id                  :bigint(8)        not null, primary key
#  name                :text             not null
#  description         :text             not null
#  strategic_focus     :text             not null
#  research_priorities :text             not null
#  foundation_date     :date             not null
#  classification      :integer          not null
#  date_classification :date             not null
#  url                 :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ResearchGroupSerializer < ActiveModel::Serializer
  type :research_group

  attributes :id, :name, :description, :strategic_focus
  attributes :research_priorities, :foundation_date, :classification
  attributes :date_classification, :url, :updated_at

  has_many :research_subjects
  has_many :publications
  has_many :careers
  has_many :events
  has_many :user_research_groups, key: :members
  has_one :photo

  def classification
    return object.classification.capitalize
  end
end
