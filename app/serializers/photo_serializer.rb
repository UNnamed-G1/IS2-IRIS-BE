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

class PhotoSerializer < ActiveModel::Serializer
  type :photo

  attributes :id, :picture, :imageable_type, :imageable_id

  belongs_to :imageable, polymorphic: true

  def picture
  	return object.picture.url
  end

end
