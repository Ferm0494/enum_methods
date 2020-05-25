require './lib/enums'

describe Enumerable do
  array = [1, 2, 5, 4, 3, 2, 3, 4, 0, 2, 3, 30]
  same = [1, 1, 1, 1]
  strings = %w[Hello World Fer]
  empty = []
  bool = [nil, true, 99]
  range = 1..25
  hash = {
    :email => "redbull@io.com",
    :name => "orio",
    :age => 70,
    :number => 5544788955
  }

  describe '#my_each' do
    it 'Returns the array itself of numbers with block' do
      expect(array.my_each { |x| }).to eql(array.each { |x| })
    end

    it 'Returns the array itself of strings with block' do
      expect(strings.my_each { |x| }).to eql(strings.each { |x| })
    end

    it 'Returns Enumerator if block not given' do
      expect(strings.my_each).to be_an(Enumerator)
    end
  end

  describe '#my_each_with_index' do
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
    it 'Returns true if no block given' do
      expect(array.my_all?).to eql(array.all?)
    end

    it 'Returns true if all elements are the same' do
      expect(array.my_all?(Numeric)).to eql(array.all?(Numeric))
    end

    it 'If argument is a regular expression, return true if there is a match for all elements' do
      expect(range.my_any?(/d/)).to eql(range.any?(/d/))
    end

    it 'Returns true if all the elements condition is met' do
      expect(strings.my_all? { |word| word.length >= 4 }).to eql(strings.all? { |word| word.length >= 4 })
    end

    it 'Returns false if one element is false/nil' do
      expect(bool.my_all?).to eql bool.all?
    end

    it 'Returns true if element is empty' do
      expect(empty.my_all?).to eql(empty.all?)
    end

    it 'Returns true if element are the same' do
      expect(same.my_all?(1)).to eql(same.all?(1))
    end

    it 'Returns false if elements are NOT the same' do
      expect(array.my_all?(1)).to eql(array.all?(1))
    end
  end

  describe '#my_any' do
    it 'Returns true if no argument is given, no block given and contains true' do
      expect(bool.my_any?).to eql(bool.any?)
    end

    it 'Returns true if any element met the condition inside the block' do
      expect(array.my_any? { |i| i > 3 }).to eql(array.any? { |i| i > 3 })
    end

    it 'Returns true if element is of the same class' do
      expect(bool.my_any?(Integer)).to eql(bool.any?(Integer))
    end

    it 'If argument is a regular expression, return true if there is a match' do
      expect(range.my_any?(/d/)).to eql(range.any?(/d/))
    end

    it 'Returns true if any of the element are the same' do
      expect(same.my_any?(1)).to eql(same.any?(1))
    end

    it 'Returns false if none of the elements are the same' do
      expect(array.my_any?(50)).to eql(array.any?(50))
    end

    it 'Returns false if element is empty' do
      expect(empty.my_any?).to eql(empty.any?)
    end
  end

  describe '#my_none' do
    it 'Returns true if no argument is given, no block given and does not contain a true element' do
      expect(bool.my_none?).to eql(bool.none?)
    end

    it 'When block is given, returns true if none of the condition inside the block is met' do
      expect(array.my_none? { |i| i > 3 }).to eql(array.none? { |i| i > 3 })
    end

    it 'Returns true if none of the element is of the same class as that of the argument' do
      expect(bool.my_none?(Integer)).to eql(bool.none?(Integer))
    end

    it 'If argument is a regular expression, return true if there is no match' do
      expect(range.my_none?(/d/)).to eql(range.none?(/d/))
    end

    it 'Returns true if none of the element are the same compared to the argument' do
      expect(same.my_none?(100)).to eql(same.none?(100))
    end

    it 'Returns true if element is empty' do
      expect(empty.my_none?).to eql(empty.none?)
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
      expect(range.my_count{|x| x%2==0}).to eql(range.count{|x| x%2==0})
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
