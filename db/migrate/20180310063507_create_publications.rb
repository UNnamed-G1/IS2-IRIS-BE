class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.string :name, limit: 255, null: false
      t.date :date, null: false
      t.text :abstract, null: false
      t.string :url, limit: 300, null: false
      t.string :brief_description, limit: 500, null: false
      t.string :file_name, limit: 300
      t.integer :type_pub, null: false

      t.timestamps
    end
  end
end
