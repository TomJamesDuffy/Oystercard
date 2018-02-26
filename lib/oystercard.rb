# This is the Oystercard class
class Oystercard
  attr_reader :balance, :use
  DEFAULT_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise 'You have exceeded your balance!' if limit?(amount)
    @balance += amount
  end

  def deduct(charge)
    raise 'You do not have enough funds to make this transaction' if min?(charge)
    @balance -= charge
  end

  def touch_in
    @use = :in
  end

  def touch_out
    @use == :in ? (@use = :out) : (raise 'You are not touched in')
  end

  def in_journey?
    @use == :in
  end

  private

  def limit?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end

  def min?(charge)
    (@balance - charge) < 0
  end
end
