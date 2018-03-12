class CreateFaculties < ActiveRecord::Migration[5.1]
  def change
    create_table :faculties do |t|
      t.string :name, limit: 100, null: false
      t.timestamps
    end
  end
end
