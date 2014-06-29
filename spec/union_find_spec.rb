require 'spec_helper'
random = Random.new

describe UnionFind::UnionFind do

  describe '#initialize' do
    context 'when number_of_components < 0' do
      it 'raises an exception' do
        expect {UnionFind::UnionFind.new(-2)}.to raise_exception(ArgumentError)
      end            
    end
    
    context 'when number_of_components == 0' do
      it 'raises an exception' do
        expect {UnionFind::UnionFind.new(0)}.to raise_exception(ArgumentError)
      end            
    end   
  end

  describe '#count_components' do
    context 'when all components are connected' do
      number_of_components = random.rand(1..999)
      union_find = UnionFind::UnionFind.new(number_of_components)

      it 'returns correct count' do
        expect(union_find.count).to eq number_of_components
      end
    end
  end

  describe '#find_root' do
    number_of_components = random.rand(1..999)
    union_find = UnionFind::UnionFind.new(number_of_components)

    context 'when component_id < 0' do
      it 'raises an exception' do
        expect {union_find.find_root(-1)}.to raise_exception(IndexError)
      end  
    end

    context 'when component_id > (number_of_components - 1)' do
      it 'raises an exception' do
        expect {union_find.find_root(number_of_components)}.to raise_exception(IndexError)
      end  
    end

    context 'when 0 <= component_id < number_of_components' do
      context 'when component_id is topmost node' do
        it 'returns same component_id' do
          component_id = [*1..number_of_components].sample
          expect(union_find.find_root(component_id)).to eq component_id
        end        
      end
    end
  end

  describe '#connected?' do
    number_of_components = random.rand(1..999)
    union_find = UnionFind::UnionFind.new(number_of_components)

    context 'when two components are not connected' do
      it 'returns false' do
        component_1_id = [*1..number_of_components].sample
        component_2_id = [*1..number_of_components].sample

        expect(union_find.connected?(component_1_id, component_2_id)).to be_falsey
      end
    end

    context 'when two components are the same' do
      it 'returns false' do
        component_1_id = [*1..number_of_components].sample

        expect(union_find.connected?(component_1_id, component_1_id)).to be_truthy
      end
    end    
  end  
end  