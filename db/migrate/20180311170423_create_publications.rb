class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.string :name, limit: 255
      t.date :date
      t.text :abstract
      t.string :url, limit: 300
      t.string :brief_description, limit: 500
      t.string :file_name, limit: 300
      t.integer :type

      t.timestamps
    end
  end
end
