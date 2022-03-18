class AddColumnsToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :start_date, :date
    add_column :reservations, :end_date, :date
    add_column :reservations, :num_of_people, :interger
  end
end
