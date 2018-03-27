class PublicationResearchGroup < ApplicationRecord
    belongs_to :publication
    belongs_to :research_group
end
