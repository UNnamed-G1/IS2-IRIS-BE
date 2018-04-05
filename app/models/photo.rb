# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  link           :text(300)
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

  validates :link, :imageable_type, presence: true
  validates :link, length: { maximum: 300, too_long: "Se permiten maximo %{count} caracteres" }
  
end
