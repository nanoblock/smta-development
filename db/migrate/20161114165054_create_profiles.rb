class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :app_name
      t.string :tel
      t.string :email
      t.text :desc

      t.timestamps null: false
    end
  end
end
