require './lib/enums'

describe Enumerable do
    let (:array) {[1,2,5,4,3,2,3,4,0,2,3,30]}
    let (:same) {[1,1,1,1]}
    let (:strings) {%w[Hello World Fer]}
    let (:empty) {[]}
    let (:bool){[nil, true, 99]}

    describe "#my_each" do
        it "Returns the array itself of numbers with block" do
            expect(array.my_each{|x| x}).to eql(array.each{|x| x})
        end

        it "Returns the array itself of strings with block" do
            expect(strings.my_each{|x| x}).to eql(strings.each{|x| x})
        end

        it  "Returns Enumerator if block not given" do
        expect(strings.my_each).to be_an(Enumerator)
        end
    end

    describe "#my_each_with_index" do
        it "Returns the array itself of numbers and index with block" do
            expect(array.my_each_with_index{|x| x}).to eql(array.each_index{|x| x})
            expect(array.my_each_with_index{|x,i| i}).to eql(array.each_index{|x,i| i})

        end

        it "Returns the array itself of strings and index with block" do
            expect(strings.my_each_with_index{|x| x}).to eql(strings.each_index{|x| x})
            expect(strings.my_each_with_index{|x,i| i}).to eql(strings.each_index{|x,i| i})
        end
        it "Returns Enumer if block not given" do
            expect(strings.my_each_with_index).to be_an(Enumerator)
        end
    end

    describe "#my_select" do
        it "Returns even numbers" do
            expect(array.my_select{ |num|  num.even?  }).to eql(array.select { |num|  num.even?  })
        end

        it "Returns odd numbers" do
            expect(array.my_select(&:odd?)).to eql(array.select(&:odd?))
        end

        it "Returns Enumerator if block not given" do
            expect(array.my_select).to be_an(Enumerator)
        end
    end

    describe "#my_all" do
        it "Returns true if no block given" do
            expect(array.my_all?).to eql(array.all?)
        end

        it "Returns true if all elements are the same" do
            expect(array.my_all?(Numeric)).to eql(array.all?(Numeric))
        end

        it "Returns true if all the elements condition is met" do
            expect(strings.my_all?{ |word| word.length >= 4 }).to eql(strings.all?{ |word| word.length >= 4 } )
        end

        it "Returns false if one element is false/nil" do
            expect(bool.my_all?).to eql (bool.all?)
        end

        it "Returns true if element is empty" do
            expect(empty.my_all?).to eql(empty.all?)
        end

        it "Returns true if element are the same" do
            expect(same.my_all?(1)).to eql(same.all?(1))
        end

        it "Returns false if elements are NOT the same" do
            expect(array.my_all?(1)).to eql(array.all?(1))
        end
    end

    describe "#my_any" do
      it "Returns true if no argument is given, no block given and contains true" do
        expect(bool.my_any?).to eql(bool.any?)
      end

      it "Returns true if any element met the condition inside the block" do
        expect(array.my_any?{|i| i > 3}).to eql(array.any?{|i| i > 3})
      end

      it "Returns true if element is of the same class" do
        expect(bool.my_any?(Integer)).to eql(bool.any?(Integer))
      end

      it "Returns true if any of the element are the same" do
          expect(same.my_any?(1)).to eql(same.any?(1))
      end

      it "Returns false if none of the elements are the same" do
          expect(array.my_any?(50)).to eql(array.any?(50))
      end

      it "Returns false if element is empty" do
          expect(empty.my_any?).to eql(empty.any?)
      end
    end


end
