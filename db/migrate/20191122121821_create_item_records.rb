class CreateItemRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :item_records do |t|
      t.string :name, null: false
      t.integer :weight
      t.integer :reps
      t.integer :seconds
      t.integer :sets
      t.boolean :checked, default: false
      t.date :date, null: false
      t.references :user, null: false, foreign_key: true
      t.references :menu_record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
