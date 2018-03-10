class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 100
      t.string :username, limit: 30
      t.string :professional_profile, limit: 5000
      t.string :email, limit: 50
      t.string :phone, limit: 15
      t.string :office, limit: 15
      t.string :cvlac_link, limit: 200

      t.timestamps
    end
  end
end
