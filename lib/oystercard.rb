# This is the Oystercard class
class Oystercard
  DEFAULT_LIMIT = 90
  FARE = 1

  attr_reader :balance, :use, :history

  def initialize
    @balance = 0
    @history = []
    @journey = Hash.new
  end

  def top_up(amount)
    raise 'You have exceeded your limit!' if limit?(amount)
    @balance += amount
  end

  def deduct(charge)
    raise 'You do not have enough funds to make this transaction' if min_out?(charge)
    @balance -= charge
  end

  def touch_in(station)
    raise 'You do not have have enough funds' if min_in?
    @entry_station, @use = station, :in
  end

  def touch_out(station)
    raise 'You are not touched in' if @use != :in
    @exit_station, @use = station, :out
    deduct(FARE)
    record_history
  end

  def in_journey?
    @use == :in
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

  def record_history
    @history.push(@journey[@entry_station] = @exit_station)    
  end
end
