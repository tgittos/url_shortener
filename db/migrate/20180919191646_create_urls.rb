class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :user_slug
      t.string :admin_slug
      t.string :long_url
      t.integer :num_clicks, default: 0

      t.timestamps
    end
  end
end
