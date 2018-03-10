class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.integer :id_product
      t.date :publication_date
      t.text :abstract
      t.text :url
      t.text :little_desc
      t.text :file_name
      t.integer :publication_type

      t.timestamps
    end
  end
end
