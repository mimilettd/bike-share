require 'will_paginate'
require 'will_paginate/active_record'

class Condition < ActiveRecord::Base
   acts_as_copy_target #for postgres copy

    has_many :trips, class_name: "Trip", foreign_key: "start_date",
         primary_key: "date"

    ZIP_CODE = 95113 #just picks one zip_code for analytics

#temp

    def self.avg_rides_by_weather(start_of_range)
      conditions = Condition.where(max_temperature:
                                   start_of_range..(start_of_range+9))
      dates_in_temp_range = conditions.select(:date).distinct.where(
                            zip_code: ZIP_CODE)
      total_trips = Trip.where(start_date: dates_in_temp_range)

      avg = total_trips.count / dates_in_temp_range.count

      avg.round
    end

    def self.high_rides_by_weather(start_of_range)
      conditions = Condition.where(max_temperature:
                                   start_of_range..(start_of_range+9))
      dates_in_temp_range = conditions.select(:date).distinct.where(
                            zip_code: ZIP_CODE)
      total_trips = Trip.where(start_date: dates_in_temp_range)
      total_trips.group(:start_date).order('count_id DESC').count(:id).values.first
    end

    def self.low_rides_by_weather(start_of_range)
      conditions = Condition.where(max_temperature:
                                   start_of_range..(start_of_range+9))
      dates_in_temp_range = conditions.select(:date).distinct.where(
                            zip_code: ZIP_CODE)
      total_trips = Trip.where(start_date: dates_in_temp_range)
      total_trips.group(:start_date).order('count_id DESC').count(:id).values.last
    end

#precip

    def self.avg_rides_by_precip(start_of_range)
      conditions = Condition.where(precipitation:
                                   start_of_range..(start_of_range+0.5))
      dates_in_temp_range = conditions.select(:date).distinct.where(
                            zip_code: ZIP_CODE)
      total_trips = Trip.where(start_date: dates_in_temp_range)
      if dates_in_temp_range.count == 0
        "no data"
      else
        avg = total_trips.count / dates_in_temp_range.count
        avg.round
      end
    end

    def self.high_rides_by_precip(start_of_range)
      conditions = Condition.where(precipitation:
                             start_of_range..(start_of_range+0.5))
      dates_in_temp_range = conditions.select(:date).distinct.where(
                            zip_code: ZIP_CODE)
      total_trips = Trip.where(start_date: dates_in_temp_range)
      total_trips.group(:start_date).order('count_id DESC').count(:id).values.first
    end

    def self.low_rides_by_precip(start_of_range)
      conditions = Condition.where(precipitation:
                             start_of_range..(start_of_range+0.5))
      dates_in_temp_range = conditions.select(:date).distinct.where(
                            zip_code: ZIP_CODE)
      total_trips = Trip.where(start_date: dates_in_temp_range)
      total_trips.group(:start_date).order('count_id DESC').count(:id).values.last
    end

#wind_speed

    def self.avg_rides_by_windspeed(start_of_range)
      conditions = Condition.where(mean_windspeed:
                                   start_of_range..(start_of_range+4))
      dates_in_temp_range = conditions.select(:date).distinct.where(
                            zip_code: ZIP_CODE)
      total_trips = Trip.where(start_date: dates_in_temp_range)

      if dates_in_temp_range.count == 0
        "no data"
      else
        avg = total_trips.count / dates_in_temp_range.count
        avg.round
      end
    end

    def self.high_rides_by_windspeed(start_of_range)
      conditions = Condition.where(mean_windspeed:
                             start_of_range..(start_of_range+4))
      dates_in_temp_range = conditions.select(:date).distinct.where(
                            zip_code: ZIP_CODE)
      total_trips = Trip.where(start_date: dates_in_temp_range)
      total_trips.group(:start_date).order('count_id DESC').count(:id).values.first
    end

    def self.low_rides_by_windspeed(start_of_range)
      conditions = Condition.where(mean_windspeed:
                             start_of_range..(start_of_range+4))
      dates_in_temp_range = conditions.select(:date).distinct.where(
                            zip_code: ZIP_CODE)
      total_trips = Trip.where(start_date: dates_in_temp_range)
      total_trips.group(:start_date).order('count_id DESC').count(:id).values.last
    end

#visibility

   def self.avg_rides_by_visibility(start_of_range)
      conditions = Condition.where(mean_visibility:
                                   start_of_range..(start_of_range+4))
      dates_in_temp_range = conditions.select(:date).distinct.where(
                            zip_code: ZIP_CODE)
      total_trips = Trip.where(start_date: dates_in_temp_range)

      if dates_in_temp_range.count == 0
        "no data"
      else
        avg = total_trips.count / dates_in_temp_range.count
        avg.round
      end
   end

    def self.high_rides_by_visibility(start_of_range)
      conditions = Condition.where(mean_visibility:
                             start_of_range..(start_of_range+4))
      dates_in_temp_range = conditions.select(:date).distinct.where(
                            zip_code: ZIP_CODE)
      total_trips = Trip.where(start_date: dates_in_temp_range)
      total_trips.group(:start_date).order('count_id DESC').count(:id).values.first
    end

    def self.low_rides_by_visibility(start_of_range)
      conditions = Condition.where(mean_visibility:
                             start_of_range..(start_of_range+4))
      dates_in_temp_range = conditions.select(:date).distinct.where(
                            zip_code: ZIP_CODE)
      total_trips = Trip.where(start_date: dates_in_temp_range)
      total_trips.group(:start_date).order('count_id DESC').count(:id).values.last
    end

#for trips dashboard

    def self.weather_on_day_with_highest_rides
      date = Trip.group(:start_date).order('count_id DESC').count(:id).keys.first
      Condition.find_by(date: date)
    end


    def self.weather_on_day_with_lowest_rides
      date = Trip.group(:start_date).order('count_id DESC').count(:id).keys.last
      if Condition.find_by(date: date) == []
        "no data"
      else
        Condition.find_by(date: date)
      end
    end
end
