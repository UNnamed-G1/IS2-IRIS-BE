# == Schema Information
#
# Table name: photos
#
#  id             :bigint(8)        not null, primary key
#  picture        :text
#  imageable_type :string
#  imageable_id   :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_photos_on_imageable_type_and_imageable_id  (imageable_type,imageable_id)
#

require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
