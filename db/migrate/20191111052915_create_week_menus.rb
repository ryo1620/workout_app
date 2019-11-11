class CreateWeekMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :week_menus do |t|
      t.integer :cwday, null: false
      t.references :user, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
