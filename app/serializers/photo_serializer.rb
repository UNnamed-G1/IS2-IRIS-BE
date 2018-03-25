class PhotoSerializer < ActiveModel::Serializer
  type :photo

  attributes :id, :link, :imageable_type, :imageable_id

  belongs_to :imageable, polymorphic: true
end
