class AddIndicesToUrl < ActiveRecord::Migration[5.2]
  def change
    add_index :urls, :user_slug
    add_index :urls, :admin_slug
  end
end
