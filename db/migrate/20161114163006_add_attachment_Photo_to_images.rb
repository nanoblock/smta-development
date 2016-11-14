class AddAttachmentPhotoToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.attachment :Photo
    end
  end

  def self.down
    remove_attachment :images, :Photo
  end
end
