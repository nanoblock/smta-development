class AddImageIdToClickables < ActiveRecord::Migration
  def self.up
    add_column :clickables, :image_id, :integer
  end

  def self.down
    remove_column :clickables, :image_id
  end
end
