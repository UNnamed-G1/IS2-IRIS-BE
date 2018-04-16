# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  start_hour :integer          not null
#  duration   :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ScheduleSerializer < ActiveModel::Serializer
  type :schedule
  
  attributes :id, :start_hour, :duration

  has_many :users
end
