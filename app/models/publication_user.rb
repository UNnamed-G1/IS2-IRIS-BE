# == Schema Information
#
# Table name: publication_users
#
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
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#  fk_rails_...  (user_id => users.id)
#

class PublicationUser < ApplicationRecord
    belongs_to :publication
    belongs_to :user
end
