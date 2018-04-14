# == Schema Information
#
# Table name: event_users
#
#  id              :integer          not null, primary key
#  type_user_event :integer          default("invitado"), not null
#  user_id         :integer
#  event_id        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_event_users_on_event_id  (event_id)
#  index_event_users_on_user_id   (user_id)
#

class EventUser < ApplicationRecord
    belongs_to :user
    belongs_to :event

    enum type_user_event: [:invitado, :asistente, :author]

    validates :type_user_event, presence: :true
    validates :type_user_event, inclusion: {in: type_user_events, message: "El tipo de usuario no es válido"}

end
