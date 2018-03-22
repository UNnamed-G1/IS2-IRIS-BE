class CreatePublicationResearchGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :publication_research_groups do |t|
      t.references :publication, foreign_key: true
      t.references :research_group, foreign_key: true

      t.timestamps
    end
  end
end
