require 'oystercard'
describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end
  describe '#top_up' do
    it{is_expected.to respond_to(:top_up).with(1).argument}
    it 'tops up the balance of the oystercard' do
      expect{subject.top_up 1}.to change{subject.balance}.by 1
    end
    it 'raises an error if the #{maximum_balance} is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up maximum_balance
      expect{subject.top_up 1}.to raise_error "Top up failed, maximum balance of #{maximum_balance} exceeded"
    end
  end
  describe '#deduct' do
    it{is_expected.to respond_to(:deduct).with(1).argument}
    it 'deducts money from the oystercard' do
      expect{subject.deduct(4)}.to change{subject.balance}.by(-4)
    end
  end

  describe '#journey_in?' do
    it {is_expected.to respond_to :journey_in?}

    it 'changes status of oystercard to tapped in' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      subject.top_up(minimum_balance)
      expect{subject.tap_in}.to change{subject.card_status}.to true
    end

    it 'does not tap in if insufficient balance on oystercard' do
      expect{subject.tap_in}.to raise_error "Insufficient balance to tap in"
    end

    it 'changes status of oystercard to tapped out' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      subject.top_up(minimum_balance)
      expect subject.tap_in
      expect{subject.tap_out}.to change{subject.card_status}.to false
    end

    it 'checks that a charge is made to the oystercard when tapped out' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      subject.top_up(minimum_balance)
      subject.tap_in
      expect{subject.tap_out}.to change{subject.balance}.by(-Oystercard::MINIMUM_CHARGE)
    end
  end

end
