class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 100, null: false
      t.string :lastname, limit: 100, null: false
      t.string :username, limit: 40
      t.string :email, null: false
      t.string :password_digest
      t.text :professional_profile, limit: 5000
      t.integer :user_type, null: false, default: 0
      t.string :phone, limit: 20
      t.string :office, limit: 20
      t.text :cvlac_link
      t.boolean :google_sign_up, default: false

      t.references :career, foreign_key: true, null: true

      t.timestamps
    end
  end
end
