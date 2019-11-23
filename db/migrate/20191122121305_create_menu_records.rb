class CreateMenuRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_records do |t|
      t.string :name, null: false
      t.boolean :checked, default: false
      t.date :date, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
