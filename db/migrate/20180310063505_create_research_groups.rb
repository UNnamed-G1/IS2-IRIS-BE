class CreateResearchGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :research_groups do |t|
<<<<<<< HEAD
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
=======
      t.text :name, null: false
      t.text :description, null: false
      t.text :strategic_focus, null: false
      t.text :research_priorities, null: false
      t.date :foundation_date, null: false
      t.string :classification, limit: 5, null: false
      t.date :date_classification, null: false
      t.string :url, limit: 300

      t.references :photo, foreign_key: true
>>>>>>> da0d017d6b98af73f220b6150bb010914eca3ae9

      t.timestamps
    end
  end
end
