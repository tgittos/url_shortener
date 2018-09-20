class AddActiveToUrls < ActiveRecord::Migration[5.2]
  def change
    add_column :urls, :active, :boolean, default: true
  end
end
