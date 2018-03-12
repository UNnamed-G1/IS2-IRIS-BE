class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
<<<<<<< HEAD
      t.integer :id_product
      t.date :publication_date
      t.text :abstract
      t.text :url
      t.text :little_desc
      t.text :file_name
      t.integer :publication_type
=======
      t.string :name, limit: 255, null: false
      t.date :date, null: false
      t.text :abstract, null: false
      t.string :url, limit: 300, null: false
      t.string :brief_description, limit: 500, null: false
      t.string :file_name, limit: 300
      t.integer :type, null: false
>>>>>>> da0d017d6b98af73f220b6150bb010914eca3ae9

      t.timestamps
    end
  end
end
