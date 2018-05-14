class CreateUserResearchGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :user_research_groups, id: false do |t|
      t.date :joining_date, null: false
      t.date :end_joining_date
      t.integer :state, :member_type, default: 0, null: false

      t.references :user, foreign_key: true
      t.references :research_group, foreign_key: true

      t.timestamps
    end
  end
end
