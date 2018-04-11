# == Schema Information
#
# Table name: publication_users
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  publication_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_publication_users_on_publication_id  (publication_id)
#  index_publication_users_on_user_id         (user_id)
#

require 'test_helper'

class PublicationUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
