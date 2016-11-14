class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :app_name
      t.text :desc
      t.string :tel
      t.string :app_email
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
