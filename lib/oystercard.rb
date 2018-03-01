require_relative 'journey.rb'
# This is the Oystercard class
class Oystercard

  DEFAULT_LIMIT = 90
  FINE = 6

  attr_reader :balance, :use, :history

  def initialize
    @balance = 0
    @history = []
    @use = :out
  end

  def top_up(amount)
    raise 'You have exceeded your limit!' if limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    journey_ongoing? ? fine_protocol(station) : new_journey(station)
  end

  def fine_protocol(station)
    raise 'You have not touched out, a fine is due but your balance is too low! Top Up!' if min_fine?
    deduct(@journey.fee(@use))
    record_history(@journey.manual_end)
    restart_journey
  end

  def restart_journey
    @journey = Journey.new 
    @use = :out 
  end

  def new_journey(station, journey = Journey.new)
    @journey = journey
    raise 'You do not have have enough funds to make this journey, top up!' if min_in?
    journey.add_entry(station)
    @use = :in 
  end

  def touch_out(station)
    raise 'You are not touched in' if @journey.entry_station.empty?
    raise 'You are already touched out' if touched_out? 
    @journey.add_exit(station)
    record_history([@journey.state])
    @use = :out
    deduct(@journey.fee(@use))
  end 

  def journey_ongoing?
    @use == :in
  end

  private

  def record_history(array)
    @history.push(array)
  end

  def deduct(charge)
    raise 'You do not have enough funds to make this transaction' if min_out?(charge)
    @balance -= charge
  end

  def limit?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end

  def min_out?(charge)
    (@balance - charge) < 0
  end

  def min_in?
    @balance < @journey.fee(@use)
  end

  def min_fine?
    @balance < @journey.fee(@use)
  end 

  def touched_out?
    !@journey.entry_station.empty? && !@journey.exit_station.empty?
  end
end
