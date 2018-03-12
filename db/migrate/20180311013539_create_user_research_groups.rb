class CreateUserResearchGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :user_research_groups, id: false do |t|
      t.date :joining_date, :end_joining_date, null: false
      t.integer :state, :type, :hours_per_week, default: 0, null: false

      t.references :users, foreign_key: true
      t.references :research_groups, foreign_key: true

      t.timestamps
    end
  end
end
