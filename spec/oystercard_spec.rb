require_relative "../lib/oystercard.rb"

describe Oystercard do
    
  # tests if an oyster card responds to balance
  describe '#balance' do
    it 'should respond to balance' do
      expect(subject).to respond_to(:balance)
    end
  end

  # Testing a top up function
  describe "#top_up" do
    it "should add money to the balance of the card" do
     expect { subject.top_up(50) }.to change { subject.balance }.by(50)
    end

    it "should stop top_up if we add something that breaks the limit" do
      expect { subject.top_up(100) }.to raise_error("this has exceeded the top up limit value of 90")
    end
  end

  # Testing the deduct method
  describe "#deduct" do
    it "should deduct money from balance of the card" do
      subject.top_up(50)
      expect { subject.deduct(20) }.to change { subject.balance }.by(-20)
    end
  end

  # Testing the touch in method
  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in) }
  end

  # Testing the touch out method
  describe "#touch_out" do
    it { is_expected.to respond_to(:touch_out) }
  end

  # Testing the in_journey? method - as it starts as false, testing for false response
  describe "#in_journey?" do
    it { is_expected.to_not be_in_journey }
  end

end