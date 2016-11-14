class CreateOcrs < ActiveRecord::Migration
  def change
    create_table :ocrs do |t|
      t.string :text
      t.string :top
      t.string :left
      t.string :width
      t.string :height

      t.timestamps null: false
    end
  end
end
