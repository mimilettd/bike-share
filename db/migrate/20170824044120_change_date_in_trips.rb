class ChangeDateInTrips < ActiveRecord::Migration[5.1]
  def change
    change_column :trips, :start_date, :date
  end
end
