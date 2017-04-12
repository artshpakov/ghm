class CreateBanners < ActiveRecord::Migration[5.0]

  def change
    create_table :banners do |t|
      t.string :title
      t.string :image
      t.string :text, limit: 100
      t.string :emails, array: true, default: []
      t.json :settings, default: {}
      t.boolean :active, default: true
      t.timestamp :created_at
    end
  end

end
