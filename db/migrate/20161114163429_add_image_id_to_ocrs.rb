class AddImageIdToOcrs < ActiveRecord::Migration
  def self.up
    add_column :ocrs, :image_id, :integer
  end

  def self.down
    remove_column :ocrs, :image_id
  end
end
