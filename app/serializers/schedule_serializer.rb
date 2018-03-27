class ScheduleSerializer < ActiveModel::Serializer
  type :schedule
  
  attributes :id, :start_date, :end_date

  has_many :users
end
