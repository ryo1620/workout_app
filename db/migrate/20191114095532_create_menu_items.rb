class CreateMenuItems < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :weight
      t.integer :reps
      t.integer :seconds
      t.integer :sets

      t.timestamps
    end
  end
end
