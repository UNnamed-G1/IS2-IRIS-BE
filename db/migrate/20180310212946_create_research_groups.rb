class CreateResearchGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :research_groups do |t|
      t.integer :id_group
      t.text :name_group
      t.text :description_group
      t.text :strategic_focus
      t.text :research_priorities
      t.date :foundation_date
      t.text :classification
      t.date :date_classification
      t.text :url_group
      t.integer :id_photo

      t.timestamps
    end
  end
end
