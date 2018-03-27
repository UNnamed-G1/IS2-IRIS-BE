# == Schema Information
#
# Table name: event_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventUser < ApplicationRecord
    belongs_to :user
    belongs_to :event
end
