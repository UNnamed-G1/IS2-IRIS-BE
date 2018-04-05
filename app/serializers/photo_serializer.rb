# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  link           :text
#  imageable_type :string
#  imageable_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_photos_on_imageable_type_and_imageable_id  (imageable_type,imageable_id)
#

class PhotoSerializer < ActiveModel::Serializer
  type :photo

  attributes :id, :link, :imageable_type, :imageable_id

  belongs_to :imageable, polymorphic: true
end
