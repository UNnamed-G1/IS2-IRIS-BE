class CreatePublicationsResearchGroupsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :research_groups, :publications do |t|
<<<<<<< HEAD
      t.index :research_group_id
      t.index :publication_id
=======
      t.references :research_group_id, foreign_key: true
      t.references :publication_id, foreign_key: true
>>>>>>> da0d017d6b98af73f220b6150bb010914eca3ae9
    end
  end
end
