# == Schema Information
#
# Table name: publication_users
#
#  user_id        :bigint(8)
#  publication_id :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_publication_users_on_publication_id  (publication_id)
#  index_publication_users_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class PublicationUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
