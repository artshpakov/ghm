class CreateIdentities < ActiveRecord::Migration

  def change
    create_table :identities do |t|
      t.belongs_to :user
      t.string :provider, :uid, null: false
      t.timestamps
    end
    add_index :identities, [:provider, :uid]
  end

end
