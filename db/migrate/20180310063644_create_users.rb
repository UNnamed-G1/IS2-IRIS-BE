class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
<<<<<<< HEAD
      t.string :name, limit: 100
      t.string :username, limit: 30
      t.string :professional_profile, limit: 5000
      t.string :email, limit: 50
      t.string :phone, limit: 15
      t.string :office, limit: 15
      t.string :cvlac_link, limit: 200

=======
      t.string :name, limit: 100, null: false
      t.string :username, limit: 40, null: false
      t.string :email, limit: 100, null: false
      t.text :professional_profile, limit: 5000, null: false
      t.integer :type, null: false
      t.string :phone, limit: 20
      t.string :office, limit: 20
      t.string :cvlac_link, limit: 200

      t.references :career, foreign_key: true
      t.references :photo, foreign_key: true

>>>>>>> da0d017d6b98af73f220b6150bb010914eca3ae9
      t.timestamps
    end
  end
end
