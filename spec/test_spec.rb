require 'spec_helper'

describe Array do
  
  describe "#length" do
  context 'when Array has 3 members' do
    a = [1,2,3]

    it '#length should return 3' do
      expect(a.length).to eq 3
    end    
  end

  context 'when Array has 4 members' do
    a = [1,2,3]
    a << 4

    it '#length should return 4' do
      expect(a.length).to eq 4
    end
  end
end
end