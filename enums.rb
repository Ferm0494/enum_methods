# rubocop:disable Metrics/ModuleLength
module Enumerables
  def my_each
    if block_given?
      each do |element|
        yield(element)
      end
    else
      puts 'Block wasnt given'
    end
  end

  def my_each_with_index
    if block_given?
      (0...size).each do |i|
        yield(i, self[i])
      end
    else
      puts 'Block wasnt given'
    end
  end

  def my_select
    if block_given?

      arr = []
      my_each do |element|
        arr << element if yield(element)
      end
    else
      puts 'Block wasnt given'
    end

    arr
  end

  def my_all?
    response = true
    if block_given?
      my_each do |element|
        response = false unless yield(element)
      end

    else
      puts 'Block wasnt given'
    end
    response
  end

  def my_any?
    response = false
    if block_given?
      my_each do |element|
        response = true if yield(element)
      end

    else
      puts 'Block wasnt given'
    end
    response
  end

  def my_none?
    response = false
    if block_given?
      my_each do |element|
        response = true if yield(element)
      end
    else
      puts 'Block wasnt given'
    end
    response
  end

  def my_count
    count = 0
    if block_given?
      my_each do |element|
        count += 1 if yield(element)
      end
    else
      puts 'Block wasnt given'
      count = size
    end
    count
  end

  def my_map(proc = nil)
    arr = []

    if proc.equal?(nil) == false
      my_each do |element|
        arr << proc.call(element)
      end
    elsif block_given?
      my_each do |element|
        arr << yield(element)
      end
    else
      return 'Block wasnt given'

    end
    arr
  end

  def my_inject(acum = 0)
    if acum.equal?(:+)
      acum = 0
      my_each do |element|
        acum += element
      end

    elsif acum.equal?(:*)
      acum = 1
      my_each do |element|
        acum *= element
      end

    elsif block_given?
      my_each do |element|
        acum = yield(acum, element)
      end
    else
      puts 'Block wasnt given'
    end
    acum
  end

  def my_multiply()
    my_inject(:*)
  end
end
# rubocop:enable Metrics/ModuleLength
# include Enumerables
# square = proc { |x| x**2 }
# [1,2,3].my_each{
#     |element|
#     puts element
# }

#  [100,200,300].my_each_with_index{
#     |index,element|
#     puts "Index #{index} and element : #{element}"
#

#  puts [1,2,400].my_select{|element| element != 400}

# puts ["Hello" "World!"].my_all?{|element| element.length > 10}

# puts [4,3,0].my_any?{|x| x> 5}

# puts [3,2,2].my_none?{|x| x == 3}

# puts [3,2,3].my_count{|x|  x > 2}

# puts [3,3,2].my_map{|x| x + 1}

# puts [4,4,10].inject{|sum,num| num + sum}

# puts [2,3,2,10].my_multiply

# puts [2, 1, 2].my_map(square) { |x|
#   x + 2
# }
