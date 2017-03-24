class PolymorphicPosts < ActiveRecord::Migration[5.0]

  def change
    add_column :posts, :kind, :string, null: false
  end

end
