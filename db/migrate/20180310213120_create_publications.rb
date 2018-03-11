class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.string :name, limit: 255
      t.date :publication_date
      t.text :abstract
      t.text :url, limit: 300
      t.text :brief_description, limit: 500
      t.text :file_name, limit: 300
      t.integer :publication_type

      t.timestamps
    end
  end
end
