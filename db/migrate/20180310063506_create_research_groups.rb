class CreateResearchGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :research_groups do |t|
      t.text :name, null: false
      t.text :description, null: false
      t.text :strategic_focus, null: false
      t.text :research_priorities, null: false
      t.date :foundation_date
      t.integer :classification
      t.date :date_classification
      t.string :url
      t.integer :state, null: false

      t.timestamps
    end
  end
end
