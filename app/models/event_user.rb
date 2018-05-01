# == Schema Information
#
# Table name: event_users
#
#  type_user_event :integer          default("invitado"), not null
#  user_id         :bigint(8)
#  event_id        :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_event_users_on_event_id  (event_id)
#  index_event_users_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#

class EventUser < ApplicationRecord
    belongs_to :user
    belongs_to :event

    enum type_user_event: [:invitado, :asistente, :autor]

    validates :type_user_event, presence: :true
    validates :type_user_event, inclusion: {in: type_user_events, message: "El tipo de usuario no es válido"}

    
end
