class UserResearchGroupSerializer < ActiveModel::Serializer
  type :member
  attributes :id, :joining_date, :end_joining_date, :state
  attributes :hours_per_week

  attribute :type_urg, key: :member_type

  belongs_to :user
  belongs_to :research_group
  

end
