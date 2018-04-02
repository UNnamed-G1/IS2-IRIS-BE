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

class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  validates :link, :imageable_type, presence: true
  validates :link, length: { maximum: 300, too_long: "Se permiten maximo %{count} caracteres" }
  
end
