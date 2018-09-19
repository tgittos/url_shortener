class AddIndexToUrlUserSlug < ActiveRecord::Migration[5.2]
  def change
    add_index :urls, :user_slug
  end
end
