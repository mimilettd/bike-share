class Trips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.integer :duration
      t.datetime :start_date
      t.string:start_station
      t.datetime :end_date
      t.string :end_station
      t.integer :bike_id
      t.string :subscription_type
      t.integer :zip_code

      t.timestamps null: false
    end
  end
end
