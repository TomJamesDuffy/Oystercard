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

  private

  def limit?(amount)
    (@balance + amount) > DEFAULT_LIMIT
  end
end
