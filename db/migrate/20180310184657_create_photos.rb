class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.text :link, limit: 300, presence: true
      t.integer :imageable_type, presence: true
      t.references :imageable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
