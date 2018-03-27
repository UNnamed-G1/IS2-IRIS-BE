# == Schema Information
#
# Table name: publication_research_groups
#
#  id                :integer          not null, primary key
#  publication_id    :integer
#  research_group_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class PublicationResearchGroup < ApplicationRecord
    belongs_to :publication
    belongs_to :research_group
end
