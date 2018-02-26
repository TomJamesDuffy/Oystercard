# This is the Oystercard class
class Oystercard
  attr_reader :balance
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

  private

  def limit?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end

  def min?(charge)
    (@balance - charge) < 0
  end
end
