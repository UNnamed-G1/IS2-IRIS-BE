class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.text :name, null: false
      t.date :date, null: false
      t.text :abstract, null: false
      t.text :document
      t.string :brief_description, limit: 500, null: false
      t.integer :type_pub, null: false

      t.timestamps
    end
  end
end
