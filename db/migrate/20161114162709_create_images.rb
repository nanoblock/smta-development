class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :xml_path

      t.timestamps null: false
    end
  end
end
