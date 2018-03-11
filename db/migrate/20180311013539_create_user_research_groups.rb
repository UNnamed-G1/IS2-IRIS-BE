class CreateUserResearchGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :user_research_groups do |t|
      t.timestamp :joining_date, presence: true
      t.integer :user_state, presence: true, default: 0
      t.integer :user_type, presence: true, default: 0
      t.integer :hours_per_week, presence: false, default: 0
      t.datetime :end_joining_date, presence:false

      t.references :users, foreign_key: true
      t.references :research_groups, foreign_key: true

      t.timestamps
    end
  end
end
