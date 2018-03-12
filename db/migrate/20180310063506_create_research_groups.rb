class CreateResearchGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :research_groups do |t|
      t.text :name, null: false
      t.text :description, null: false
      t.text :strategic_focus, null: false
      t.text :research_priorities, null: false
      t.date :foundation_date, null: false
      t.string :classification, limit: 5, null: false
      t.date :date_classification, null: false
      t.string :url, limit: 300

      t.references :photo, foreign_key: true

      t.timestamps
    end
  end
end
