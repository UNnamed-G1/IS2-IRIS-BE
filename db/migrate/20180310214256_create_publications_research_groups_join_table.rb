class CreatePublicationsResearchGroupsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :research_groups, :publications do |t|
      t.index :research_group_id
      t.index :publication_id
    end
  end
end
