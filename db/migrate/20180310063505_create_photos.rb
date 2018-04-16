class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.text :picture
      t.string :imageable_type, null: false
      t.references :imageable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
