class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.text :name, null: false
      t.date :date, null: false
      t.text :abstract, null: false
      t.text :document
      t.string :brief_description, limit: 500, null: false
      t.integer :publication_type, null: false
      t.integer :distinction_type, null: false 
      
      t.integer :state, null: false, default: 0

      t.timestamps
    end
  end
end
