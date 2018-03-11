class CreateResearchGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :research_groups do |t|
      t.text :name_group, null: false
      t.text :description_group, null: false
      t.text :strategic_focus, null: false
      t.text :research_priorities, null: false
      t.date :foundation_date, null: false
      t.string :classification, limit: 5, null: false
      t.date :date_classification, null: false
      t.string :url_group, limit: 300

      t.timestamps
    end
  end
end
