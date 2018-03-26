class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 100
      t.string :lastname, limit: 100
      t.string :username, limit: 40
      t.string :email, null: false
      t.string :password_digest, null: false
      t.text :professional_profile, limit: 5000
      t.integer :type_u, null: false
      t.string :phone, limit: 20
      t.string :office, limit: 20
      t.string :cvlac_link

      t.references :career, foreign_key: true, null: true

      t.timestamps
    end
  end
end
