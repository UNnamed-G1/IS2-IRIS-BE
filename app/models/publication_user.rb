class PublicationUser < ApplicationRecord
    belongs_to :publication
    belongs_to :user
end
