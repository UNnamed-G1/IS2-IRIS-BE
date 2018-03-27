# == Schema Information
#
# Table name: user_research_groups
#
#  joining_date      :date             not null
#  end_joining_date  :date             not null
#  state             :integer          default("retirado"), not null
#  type_urg          :integer          default("miembro"), not null
#  hours_per_week    :integer          default(0), not null
#  user_id           :integer
#  research_group_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class UserResearchGroupSerializer < ActiveModel::Serializer
  type :member
  attributes :id, :joining_date, :end_joining_date, :state
  attributes :hours_per_week

  attribute :type_urg, key: :member_type

  belongs_to :user
  belongs_to :research_group
  

end
