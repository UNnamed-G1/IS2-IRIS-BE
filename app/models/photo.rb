class Photo < ApplicationRecord
  has_and_belongs_to_many :events

  validates :link, :type_imageable, presence: true;
end
