# == Schema Information
#
# Table name: events
#
#  id                :bigint(8)        not null, primary key
#  research_group_id :bigint(8)
#  name              :string           not null
#  topic             :text             not null
#  description       :text             not null
#  event_type        :integer          not null
#  date              :datetime         not null
#  frequence         :integer          not null
#  duration          :time             not null
#  state             :integer          not null
#  latitude          :float
#  longitude         :float
#  address           :string
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

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
