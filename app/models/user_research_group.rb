# == Schema Information
#
# Table name: user_research_groups
#
#  joining_date      :date             not null
#  end_joining_date  :date
#  state             :integer          default("retirado"), not null
#  type_urg          :integer          default("miembro"), not null
#  user_id           :bigint(8)
#  research_group_id :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_user_research_groups_on_research_group_id  (research_group_id)
#  index_user_research_groups_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (research_group_id => research_groups.id)
#  fk_rails_...  (user_id => users.id)
#

class UserResearchGroup < ApplicationRecord
  belongs_to :user, class_name: "User"
  belongs_to :research_group, class_name: "ResearchGroup"
  
  enum state: [:retirado, :activo]
  enum type_urg: [:miembro, :lider]
  
  validates :joining_date, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha de vinculación") } }
  validates :type_urg, presence: { message: Proc.new { ApplicationRecord.presence_msg("tipo de miembro del grupo") } }
  validates :state, presence: { message: Proc.new { ApplicationRecord.presence_msg("estado") } }
  validates :state, inclusion: {in: states, message: "El estado seleccionado no es valido."}
  validates :type_urg, inclusion: {in: type_urgs, message: "El tipo de usuario seleccionado no es valido."}

  scope :lider, ->{ where(type_urg: :lider) }
  scope :is_retired, ->{ where(type_urg: :retirado) }
  scope :is_active, ->{ where(type_urg: :activo) }
end
