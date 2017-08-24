class ChangeCondition < ActiveRecord::Migration[5.1]
  def change
    change_table(:conditions) do |t|
      t.remove :max_dew_point_f
      t.remove :mean_dew_point_f
      t.remove :min_dew_point_f
      t.remove :max_humidity
      t.remove :min_humidity
      t.remove :max_sea_level_pressure_inches
      t.remove :mean_sea_level_pressure_inches
      t.remove :min_sea_level_pressure_inches
      t.remove :max_visibility_miles
      t.remove :min_visibility_miles
      t.remove :max_wind_Speed_mph
      t.remove :max_gust_speed_mph
      t.remove :cloud_cover
      t.remove :events
      t.remove :wind_dir_degrees
  end

  change_table(:conditions) do |t|
      t.rename :max_temperature_f, :max_temperature
      t.rename :mean_temperature_f, :mean_temperature
      t.rename :min_temperature_f, :min_temperature
      t.rename :mean_visibility_miles, :mean_visibility
      t.rename :mean_wind_speed_mph, :mean_windspeed
      t.rename :precipitation_inches, :precipitation
    end
  end
end
