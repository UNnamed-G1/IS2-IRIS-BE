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

class ScheduleSerializer < ActiveModel::Serializer
  type :schedule
  
  attributes :id, :start_date, :end_date

  has_many :users
end
