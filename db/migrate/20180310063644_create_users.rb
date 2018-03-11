class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 100, null: false
      t.string :username, limit: 40, null: false
      t.text :professional_profile, limit: 5000, null: false
      t.string :email, limit: 100, null: false
      t.string :phone, limit: 20
      t.string :office, limit: 20
      t.string :cvlac_link, limit: 200

      t.timestamps
    end
  end
end
