# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  picture        :text
#  imageable_type :string
#  imageable_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_photos_on_imageable_type_and_imageable_id  (imageable_type,imageable_id)
#

class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  mount_uploader :picture, PictureUploader

  validates_integrity_of :picture
  validates_processing_of :picture

  validates :imageable_type, presence: true  

  def self.create_photo(picture, imageable)
    return Photo.create(
      picture: picture,
      imageable: imageable
    )
  end

  def self.items(p)
    paginate(page: p, per_page: 12)
  end
end
