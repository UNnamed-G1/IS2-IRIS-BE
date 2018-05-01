# == Schema Information
#
# Table name: events
#
#  id                :bigint(8)        not null, primary key
#  research_group_id :bigint(8)
#  name              :string           not null
#  topic             :text             not null
#  description       :text             not null
#  type_ev           :integer          not null
#  date              :datetime         not null
#  frequence         :integer          not null
#  duration          :time             not null
#  state             :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_events_on_research_group_id  (research_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (research_group_id => research_groups.id)
#

class EventSerializer < ActiveModel::Serializer
  type :event
  
  attributes :id, :topic, :description, :date
  attributes :frequence, :duration, :state, :name
  attributes :latitude, :longitude, :address

  attribute :type_ev, key: :event_type

  has_many :users
  has_many :photos
  belongs_to :research_group

  def type_ev
    return object.type_ev.capitalize
  end

  def frequence
    return object.frequence.capitalize
  end

  def state
    return object.state.capitalize
  end

  def duration
    return object.duration.to_formatted_s(:time)
  end 
end
