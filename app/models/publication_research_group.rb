# == Schema Information
#
# Table name: publication_research_groups
#
#  publication_id    :bigint(8)
#  research_group_id :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_publication_research_groups_on_publication_id     (publication_id)
#  index_publication_research_groups_on_research_group_id  (research_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (publication_id => publications.id)
#  fk_rails_...  (research_group_id => research_groups.id)
#

class PublicationResearchGroup < ApplicationRecord
    belongs_to :publication
    belongs_to :research_group
end
