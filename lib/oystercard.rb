# This is the Oystercard class
class Oystercard
  attr_reader :balance, :use, :history
  DEFAULT_LIMIT = 90
  FARE = 1

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
    @use = :in
    @history.push("Touched at #{station}")
  end

  def touch_out
    raise 'You are not touched in' if @use != :in
    @use = :out
    deduct(FARE)
    @history.pop
  end

  def in_journey?
    !@history.empty?
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
