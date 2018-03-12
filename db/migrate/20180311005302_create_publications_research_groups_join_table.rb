class CreatePublicationsResearchGroupsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :research_groups, :publications do |t|
      t.references :research_group, foreign_key: true
      t.references :publication, foreign_key: true
    end
  end
end
