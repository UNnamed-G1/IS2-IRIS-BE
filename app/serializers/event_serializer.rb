class EventSerializer < ActiveModel::Serializer
  type :event
  
  attributes :id, :topic, :description, :date
  attributes :frequence, :end_time, :state

  attribute :type_ev, key: :event_type

  has_many :users
  has_many :photos
  belongs_to :research_group
end
