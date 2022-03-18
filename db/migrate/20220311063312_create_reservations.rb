class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :user_id, presence: true
      t.integer :room_id, presence: true

      t.timestamps
    end
  end
end
