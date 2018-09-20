class RemoveSlugsFromAndAddSaltToUrls < ActiveRecord::Migration[5.2]
  def change
    remove_column :urls, :user_slug, :string
  end
end
