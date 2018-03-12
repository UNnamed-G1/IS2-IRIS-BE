class CreateCareers < ActiveRecord::Migration[5.1]
  def change
    create_table :careers do |t|
      t.string :name, limit: 100, null: false
      t.integer :snies_code, null: false
      t.integer :degree_type, default: 0, null: false # Managed as an enum into the model

      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
