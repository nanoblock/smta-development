class CreateVideoClickables < ActiveRecord::Migration
  def change
    create_table :video_clickables do |t|
      t.float :time
      t.string :top
      t.string :left
      t.string :width
      t.string :height

      t.timestamps null: false
    end
  end
end
