require_relative 'oystercard.rb'
require_relative 'journey.rb'

class JourneyLog

  attr_reader :log, :journey

  def initialize
    @log = []
  end

  def start(station, journey = Journey.new)
    @start_station, @journey = station, journey
    journey.add_entry(@start_station)
    @journey
  end

  def end(station)
    @journey.add_exit(station)
    @log.push(@journey)
  end

  def fee(use)
    (use == :in) ? 6 : fare_calculation(@journey)
  end

  def fare_calculation(journey)
    (journey.entry_station.zone - journey.exit_station.zone).abs
  end

  def journeys
    @log.each {|journey| puts "Start: #{journey.entry_station} End: #{journey.exit_station}"} 
  end
end
