# Oystercard Task (Makers Academy Weekly Task)

A basic simulation of the Oystercard travel system.

## Contents
/lib  
journey_log.rb
journey.rb
oystercard.rb
station.rb

/spec  
journey_log_spec.rb
journey_spec.rb
oystercard_spec.rb
station_spec.rb

## Getting Started

1) Clone or download and unzip repository.   
`git clone https://github.com/TomJamesDuffy/oystercard.git`

2) Install dependencies listed in the Gemfile
`bundle install`  

## Instructions for use

There are four objects in the program - the journey log, journey, oystercard and the station.

**Oystercard**  

Using your oystercard you can touch in, touch out and top up. Should you fail to touch out an exception will be raised and you will be fined. Or, if you do not have the funds to make a journey an exception will be raised preventing you from doing so.  

oystercard.top_up(amount)  
oystercard.touch_in(station)  
oystercard.touch_out(station)  

**Station**

On initialization you must identify the stations zone and name.

station = Station.new(zone, name)

**JourneyLog**

The journey log will automatically record all journeys taken by the oystercard.

To query the journey log:

journeyLog.journeys

**Journey**

These will be automatically created as you touch in and touch out.

## Testing

If you have followed the above instructions dependencies will be installed. To run the tests proceed to the home directory and run Rspec.

`rspec`
