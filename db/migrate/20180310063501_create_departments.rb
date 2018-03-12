class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :name, limit: 100
      t.references :faculty, foreign_key: true
      t.timestamps
    end
  end
end
