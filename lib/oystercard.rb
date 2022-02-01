# frozen_string_literal: true

# Create instances of Oyster Card
class Oystercard
  CARD_LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance
  attr_reader :entry_station


  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    raise "this has exceeded the top up limit value of #{CARD_LIMIT}" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient balance' if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def over_limit?(amount)
    @balance + amount > CARD_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end
end
