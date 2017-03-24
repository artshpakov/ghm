class Following < ActiveRecord::Base

  belongs_to :user, foreign_key: :follower_id
  belongs_to :user, foreign_key: :object_id

end
