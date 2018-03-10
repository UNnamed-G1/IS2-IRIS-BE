class Photo < ApplicationRecord

  validates :link, :type_imageable, presence: true;
end
