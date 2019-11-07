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
    it 'raises an error if the maximum balance is exceeded' do
      expect{subject.top_up(91)}.to raise_error "Top up failed, maximum balance exceeded"
    end 
  end
end
