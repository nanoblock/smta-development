class AddUserIdToTokens < ActiveRecord::Migration
  def self.up
    add_column :tokens, :user_id, :integer
  end

  def self.down
    remove_column :tokens, :user_id
  end
end
