class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :address
      t.integer :price_per_day
      t.string :introduction
      t.integer :user_id

      t.timestamps
    end
  end
end
