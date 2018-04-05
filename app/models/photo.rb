class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  validates :link, :imageable_type, presence: true  
end
