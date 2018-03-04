require_relative 'journey_log.rb'

class Oystercard

  DEFAULT_LIMIT = 90

  attr_reader :balance, :use

  def initialize
    @balance = 0
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
    deduct(@journeyLog.fee(@use))
    @journeyLog.end("")
    @use = :out 
    new_journey(station)
  end

  def new_journey(station, journeyLog = JourneyLog.new)
    @journeyLog = journeyLog
    @journey_pb = @journeyLog.start(station)
    @use = :in 
  end

  def touch_out(station)
    raise 'You are not touched in' if !journey_ongoing? 
    @journeyLog.end(station)
    @use = :out
    deduct(@journeyLog.fee(@use))
  end 

  def journey_ongoing?
    @use == :in
  end

  private

  def deduct(charge)
    raise 'You do not have enough funds to make this transaction' if (@balance - charge) < 0 
    @balance -= charge
  end

  def limit?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end

  def funds?
    @balance < @journeyLog.fee(@use)
  end 
end
