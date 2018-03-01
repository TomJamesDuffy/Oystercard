require_relative 'station.rb'

class Journey
  attr_reader :entry_station, :exit_station 

  def initialize
    @entry_station = "" 
    @exit_station = ""
  end 

  def add_entry(station)
    @entry_station = station 
  end

  def add_exit(station)
    @exit_station = station
  end

  def manual_end
    @exit_station = nil
    [@entry_station, @exit_station]
  end

  def fee(use)
    (use == :in) ? 6 : 1 #fine || #fare
  end

  def state
    [@entry_station, @exit_station]
  end
end
