# frozen_string_literal: true

require_relative '../lib/oystercard'

describe Oystercard do
  let(:station) { double (:station) }
  let(:journey){ {:entry_station=>station, :exit_station=>station} }
  # tests if an oyster card responds to balance
  describe '#balance' do
    it 'should respond to balance' do
      expect(subject).to respond_to(:balance)
    end
  end
  
  # Testing a top up function
  describe '#top_up' do
    it 'should add money to the balance of the card' do
      expect { subject.top_up(50) }.to change { subject.balance }.by(50)
    end

    it 'should stop top_up if we add something that breaks the limit' do
      expect do
        subject.top_up(Oystercard::CARD_LIMIT + 1)
      end.to raise_error("this has exceeded the top up limit value of #{Oystercard::CARD_LIMIT}")
    end
  end

  # Testing the touch in method
  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).arguments }

    it 'should not allow check in if balance lower than minimum single fair' do
      allow(subject).to receive(:balance) { Oystercard::MINIMUM_FARE - 0.5 }
      expect { subject.touch_in(station) }.to raise_error('Insufficient balance')
    end

    it "should know we're in a journey when we touch in" do
      subject.top_up(30)
      expect { subject.touch_in(station) }.to change { subject.in_journey? }.to(true)
    end

    it "should remember the entry station following a touch in" do
      subject.top_up(30)
      # allow(subject).to receive(:entry_station).and_return("Picadilly")
      # subject_double = double('subject', :entry_station => "Picadilly")
      expect { subject.touch_in("Picadilly") }.to change {subject.entry_station}.from(nil).to("Picadilly")
    end
  end

  # Testing the touch out method
  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out).with(1).arguments }

    it "should know we're no longer in a journey when we touch out" do
      subject.top_up(30)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change { subject.in_journey? }.to(false)
    end

    it "should deduct minimum fare from balance" do
      subject.top_up(Oystercard::CARD_LIMIT)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change { subject.balance }.by(-(Oystercard::MINIMUM_FARE))
    end

    it "should create a journey when touching in and out" do
      subject.top_up(Oystercard::CARD_LIMIT)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journeys).to include journey
    end
  end

  describe '#journeys' do
    it "should return an empty hash by default" do
      expect(subject.journeys).to be_empty
    end
  end
  # Testing the in_journey? method - as it starts as false, testing for false response
  describe '#in_journey?' do
    it { is_expected.to_not be_in_journey }
  end

end