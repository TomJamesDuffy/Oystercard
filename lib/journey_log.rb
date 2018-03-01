require_relative 'oystercard.rb'
require_relative 'journey.rb'

class JourneyLog

  attr_reader :log, :journey, :start_station, :end_station

  def initialize
    @log = []
    @start_station = ""
    @end_station = ""
  end

  def start(station, journey = Journey.new)
    @journey = journey
    @start_station = station
  end

  def end(station)
    @end_station = station
    @log << [@start_station, @end_station]
  end

  def journeys
    [@start_station, @end_station]
  end

  private
  def current_journey
    [@start_station, @end_station] if @start_station == "" || @end_station == ""
    journey = Journey.new
  end 
end
