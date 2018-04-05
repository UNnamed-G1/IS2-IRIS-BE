# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  start_date :datetime         not null
#  end_date   :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Schedule < ApplicationRecord
  has_many :schedule_users
  has_many :users, through: :schedule_users

  validates :start_date, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha de inicio") } }
  validates :end_date, presence: { message: Proc.new { ApplicationRecord.presence_msg("fecha de inicio") } }
  
  ###Queries for searching
  
  def self.find_schedules_by_user(usr_id)
    select(:start_date).joins(:users)
                       .where('users.id' => usr_id) if usr_id.present?
  
  end  
  
end
