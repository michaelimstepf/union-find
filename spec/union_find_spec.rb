require 'spec_helper'
random = Random.new

describe UnionFind::UnionFind do
  # 1 family and 1 single person
  people = ['Grandfather', 'Father', 'Mother', 'Son', 'Daughter', 'Single']

  describe '#initialize' do    
    context 'when no components are provided' do
      it 'raises an exception' do
        expect {UnionFind::UnionFind.new()}.to raise_exception(ArgumentError)
      end            
    end

    context 'when components in form other than Array are provided' do
      it 'raises an exception' do
        expect {UnionFind::UnionFind.new('Some Person')}.to raise_exception(ArgumentError)
      end            
    end         
  end

  describe '#find_root' do
    union_find = UnionFind::UnionFind.new(people)

    context 'when component does not exist' do
      it 'raises an exception' do
        expect {union_find.find_root('Some Person')}.to raise_exception(IndexError)
      end  
    end

    context 'when component exists' do
      context 'when component has no parent' do
        it 'returns same component' do
          expect(union_find.find_root('Single')).to eq 'Single'
        end        
      end

      context 'when component has parent' do
        create_family_tree(union_find)
        
        it 'returns parent' do
          expect(union_find.find_root('Daughter')).to eq 'Grandfather'
        end        
      end
    end
  end  

  describe '#union' do
    context 'when one component gets connected to itself' do
      union_find = UnionFind::UnionFind.new(people)      
      
      it 'returns the component' do
        expect(union_find.union('Grandfather', 'Grandfather')).to be_nil
      end
    end

    context 'when one unconnected component gets connected to another unconnected component' do
      union_find = UnionFind::UnionFind.new(people)            
      
      it 'returns the first component' do
        expect(union_find.union('Grandfather', 'Father')).to eq 'Grandfather'
      end
    end

    context 'when one unconnected component gets connected to a connected component' do
      union_find = UnionFind::UnionFind.new(people)                  
      create_family_tree(union_find)
      
      it 'connects and returns the root of the larger tree' do
        expect(union_find.union('Single', 'Father')).to eq 'Grandfather'
        expect(union_find.connected?('Father', 'Single')).to be_truthy
        expect(union_find.find_root('Father')).to eq 'Grandfather'
        expect(union_find.find_root('Single')).to eq 'Grandfather'                
      end
    end         
  end

  describe '#connected?' do
    union_find = UnionFind::UnionFind.new(people)
    create_family_tree(union_find)

    context 'when two components are not connected' do
      it 'returns false' do
        expect(union_find.connected?('Father', 'Single')).to be_falsey
      end
    end

    context 'when two components are the same' do
      it 'returns false' do
        expect(union_find.connected?('Father', 'Father')).to be_truthy
      end
    end

    context 'when two components are connected' do
      it 'returns false' do
        expect(union_find.connected?('Grandfather', 'Daughter')).to be_truthy
      end
    end         
  end

  describe '#count_isolated_components' do
    context 'when no connections have been made' do
      union_find = UnionFind::UnionFind.new(people)

      it 'returns number of components' do
        expect(union_find.count_isolated_components).to eq people.size        
      end 
    end

    context 'when connections have been made' do
      union_find = UnionFind::UnionFind.new(people)
      create_family_tree(union_find)

      it 'returns number of components' do
        expect(union_find.count_isolated_components).to eq 2        
      end
    end
  end   
end  