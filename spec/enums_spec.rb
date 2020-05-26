require './lib/enums'

describe Enumerable do
  array = [1, 2, 5, 4, 3, 2, 3, 4, 0, 2, 3, 30]
  same = [1, 1, 1, 1]
  strings = %w[Hello World Fer]
  empty = []
  bool = [nil, true, 99]
  range = 1..25

  describe '#my_each' do
    it 'Returns the array itself of numbers with block' do
      expect(array.my_each { |x| }).to eql(array.each { |x| })
    end

    it 'Returns error if a parameter is given' do
      expect { array.my_each(2) }.to raise_error(ArgumentError)
    end

    it 'Returns the array itself of strings with block' do
      expect(strings.my_each { |x| }).to eql(strings.each { |x| })
    end

    it 'Returns Enumerator if block not given' do
      expect(strings.my_each).to be_an(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'Returns error if a parameter is given' do
      expect { array.my_each_with_index(2) }.to raise_error(ArgumentError)
    end

    it 'Returns the array itself of numbers and index with block' do
      expect(array.my_each_with_index { |x| x }).to eql(array.each_index { |x| x })
      expect(array.my_each_with_index { |_x, i| i }).to eql(array.each_index { |_x, i| i })
    end

    it 'Returns the array itself of strings and index with block' do
      expect(strings.my_each_with_index { |x| x }).to eql(strings.each_index { |x| x })
      expect(strings.my_each_with_index { |_x, i| i }).to eql(strings.each_index { |_x, i| i })
    end
    it 'Returns Enumer if block not given' do
      expect(strings.my_each_with_index).to be_an(Enumerator)
    end
  end

  describe '#my_select' do
    it 'Returns error if a parameter is given' do
      expect { array.my_select(2) }.to raise_error(ArgumentError)
    end

    it 'Returns even numbers' do
      expect(array.my_select(&:even?)).to eql(array.select(&:even?))
    end

    it 'Returns odd numbers' do
      expect(array.my_select(&:odd?)).to eql(array.select(&:odd?))
    end

    it 'Returns Enumerator if block not given' do
      expect(array.my_select).to be_an(Enumerator)
    end
  end

  describe '#my_all' do
    it 'Returns for positive test case with block' do
      expect(array.my_all? { |x| x >= 0 }).to eql(true)
    end

    it 'Returns false for false test case with block' do
      expect(array.my_all? { |x| x > 5 }).to eql(false)
    end

    it 'Returns true if no block give and elements are true' do
      expect(array.my_all?).to eql true
    end

    it 'Returns false if one element is false/nil' do
      expect(bool.my_all?).to eql false
    end

    it 'Returns true if all elements are the same' do
      expect(array.my_all?(Numeric)).to eql(true)
    end

    it 'Returns false if all elements are not the same' do
      expect(array.my_all?(String)).to eql(false)
    end

    it 'If argument is a regular expression, return true if there is a match ' do
      expect(range.my_any?(/d/)).to eql(range.any?(/d/))
    end

    it 'Returns true if all the elements condition is met compared to original method' do
      expect(strings.my_all? { |word| word.length >= 4 }).to eql(strings.all? { |word| word.length >= 4 })
    end

    it 'Returns true if element is empty' do
      expect(empty.my_all?).to eql(true)
    end

    it 'Returns true if element are the same' do
      expect(same.my_all?(1)).to eql(true)
    end

    it 'Returns false if elements are NOT the same' do
      expect(array.my_all?(1)).to eql false
    end
  end

  describe '#my_any' do
    it 'Returns true if no argument is given, no block given and contains true' do
      expect(bool.my_any?).to eql(true)
    end

    it 'Returns false if all of the elements are false/nil' do
      expect([false, false, nil].my_any?).to eql(false)
    end

    it 'Returns true if any element met the condition inside the block' do
      expect(array.my_any? { |i| i > 3 }).to eql(true)
    end

    it 'Returns false if none of the elements met the condition inside the block' do
      expect(array.my_any? { |i| i > 100 }).to eql(false)
    end

    it 'Returns true if element is of the same class' do
      expect(array.my_any?(Integer)).to eql(true)
    end

    it 'Returns false if element is NOT of the same class' do
      expect(array.my_any?(String)).to eql(false)
    end

    it 'If argument is a regular expression, return true if there is a match' do
      expect(strings.my_any?(/e/)).to eql(true)
    end

    it 'If argument is a regular expression, return false if there is no a single match' do
      expect(range.my_any?(/d/)).to eql(false)
    end

    it 'Returns true if any of the element are the same' do
      expect(same.my_any?(1)).to eql(true)
    end

    it 'Returns false if none of the elements are the same' do
      expect(array.my_any?(50)).to eql(false)
    end

    it 'Returns false if element is empty' do
      expect(empty.my_any?).to eql(false)
    end
  end

  describe '#my_none' do
    it 'Returns false if no argument is given, no block given, and at least one element is true' do
      expect(bool.my_none?).to eql(false)
    end

    it 'Returns true if no argument is given, no block given, and at all elements are false' do
      expect([false, nil, false].my_none?).to eql(true)
    end

    it 'When block is given, returns false if at least one element meet the condition ' do
      expect(array.my_none? { |i| i > 3 }).to eql(false)
    end

    it 'When block is given, returns true if none of the elements meet the condition' do
      expect(array.my_none? { |i| i > 100 }).to eql(true)
    end

    it 'Returns false if none of the element is of the same class as that of the argument' do
      expect(bool.my_none?(Integer)).to eql(false)
    end

    it 'Returns true if all elements are NOT the same class as that of the argument' do
      expect(strings.my_none?(Integer)).to eql(true)
    end

    it 'Returns false if at least one of the element are the same compared to the argument' do
      expect(array.my_none?(1)).to eql(false)
    end

    it 'Returns true if none of the element are the same compared to the argument' do
      expect(same.my_none?(100)).to eql(true)
    end

    it 'If argument is a regular expression, return true if there is no match' do
      expect(range.my_none?(/d/)).to eql(range.none?(/d/))
    end

    it 'Returns true if element is empty' do
      expect(empty.my_none?).to eql(true)
    end
  end

  describe '#my_count' do
    it 'Returns a summation of all the elements if no argument is given' do
      expect(array.my_count).to eql(array.count)
    end

    it 'Returns number of items that are equal to argument' do
      expect(array.my_count(3)).to eql(array.count(3))
    end

    it 'Returns number of elements that satisfies the condition of the proc given in the argument' do
      expect(array.my_count(&:even?)).to eql(array.count(&:even?))
    end

    it 'When block is given, return number of items that satisfies the condition by the block' do
      expect(range.my_count(&:even?)).to eql(range.count(&:even?))
    end
  end

  describe '#my_map' do
    it 'Returns a new array containing the elements that satisfies the conditions of the block' do
      expect(array.my_map { |x| x * x }).to eql(array.map { |x| x * x })
    end

    it 'Returns a new array containing the elements in the range that satisfies the conditions of the block' do
      expect(range.my_map { |x| x * x }).to eql(range.map { |x| x * x })
    end

    it 'Returns an Enumerator if no block is given' do
      expect(array.my_map).to be_an(Enumerator)
    end
  end

  describe '#my_inject' do
    it 'Returns a Combination of all elements by applying a binary operation specified by a symbol' do
      expect(array.my_inject(:*)).to eql(array.my_inject(:*))
    end

    it 'Applies combination on elements within the range specified by a symbol' do
      expect(range.my_inject(:*)).to eql(range.my_inject(:*))
    end

    it 'Applies combination specified by symbol' do
      expect(array.my_inject(1, :*)).to eql(array.inject(1, :*))
    end

    it 'it Returns a Combination of all elements by applying a binary operation specified by the block' do
      expect(array.my_inject(1) { |product, n| product * n }).to eql(array.inject(1) { |product, n| product * n })
    end
  end
end
