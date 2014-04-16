require 'spec_helper'

describe Array do
  describe '#eleventh' do
    it 'should return the eleventh element' do
      (1..100).to_a.eleventh.should eq(11)
    end
    it 'should return nil if eleventh element does not exist' do
      (1..5).to_a.eleventh.should eq(nil)
    end
  end
end

