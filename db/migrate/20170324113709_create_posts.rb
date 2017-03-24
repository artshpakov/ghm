class CreatePosts < ActiveRecord::Migration[5.0]

  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.string :title, null: false
      t.text :text, null: false
      t.string :slug, null: false
      t.string :source
      t.string :tags, array: true, default: []
      t.integer :likes, array: true, default: []
      t.timestamps
    end
  end

end
