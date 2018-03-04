require_relative './journey.rb'
require_relative './journey_log.rb'
require_relative './station.rb'
require_relative './oystercard.rb'

card = Oystercard.new
bank = Station.new(1, "Bank")
aldgate = Station.new(2, "Bank")
kings_cross = Station.new(3, "Kings Cross")

card.top_up(10)
card.touch_in(bank)
card.touch_out(aldgate)

card.touch_in(bank)
card.touch_in(bank)

