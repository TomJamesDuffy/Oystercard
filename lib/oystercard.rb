# This is the Oystercard class
class Oystercard
  DEFAULT_LIMIT = 90
  FARE = 1

  attr_reader :balance, :use, :history

  def initialize
    @balance = 0
    @history = []
  end

  def top_up(amount)
    raise 'You have exceeded your balance!' if limit?(amount)
    @balance += amount
  end

  def deduct(charge)
    raise 'You do not have enough funds to make this transaction' if min_out?(charge)
    @balance -= charge
  end

  def touch_in(station)
    raise 'You do not have have enough funds' if min_in?
    @entry_station, @use = station, :out
    @history.push("Touched in at #{station}")
  end

  def touch_out
    raise 'You are not touched in' if @use != :in
    deduct(FARE)
    @entry_station, @use = nil, :out
    @history.push("Touched out at #{station}")
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

  def limit?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end

  def min_out?(charge)
    (@balance - charge) < 0
  end

  def min_in?
    @balance < FARE
  end
end
