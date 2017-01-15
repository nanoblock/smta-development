class AddVideoIdToVideoClickables < ActiveRecord::Migration
  def self.up
    add_column :video_clickables, :video_id, :integer
  end

  def self.down
    remove_column :video_clickables, :video_id
  end
end
