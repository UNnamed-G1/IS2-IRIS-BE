class CreateCareers < ActiveRecord::Migration[5.1]
  def change
    create_table :careers do |t|
      t.string :name, limit: 100
      t.integer :snies_code
      t.integer :degree_type, default: 0 # Manage as a enum into the model

      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
