# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  name                 :string(100)      not null
#  lastname             :string(100)      not null
#  username             :string(40)
#  email                :string           not null
#  password_digest      :string
#  professional_profile :text
#  user_type            :integer          default("estudiante"), not null
#  phone                :string(20)
#  office               :string(20)
#  cvlac_link           :text
#  google_sign_up       :boolean          default(FALSE)
#  career_id            :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_users_on_career_id  (career_id)
#
# Foreign Keys
#
#  fk_rails_...  (career_id => careers.id)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
