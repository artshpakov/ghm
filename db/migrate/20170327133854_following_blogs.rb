class FollowingBlogs < ActiveRecord::Migration

  def change
    create_table :followings, id: false do |t|
      t.integer :follower_id, null: false
      t.integer :object_id, null: false
    end
  end

end
