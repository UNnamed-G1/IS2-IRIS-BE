# == Schema Information
#
# Table name: events
#
#  id                :integer          not null, primary key
#  research_group_id :integer
#  topic             :text             not null
#  description       :text             not null
#  type_ev           :integer          not null
#  date              :datetime         not null
#  frequence         :integer          not null
#  end_time          :datetime         not null
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
  attributes :frequence, :end_time, :state

  attribute :type_ev, key: :event_type

  has_many :users
  has_many :photos
  belongs_to :research_group
end
