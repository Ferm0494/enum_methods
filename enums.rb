# rubocop:disable Style/For
# rubocop:disable Metrics/ModuleLength
module Enumerable
  def my_each
    if block_given?
      for element in self
        yield(element)
      end
    else
      to_enum
    end
  end

  def my_each_with_index
    if block_given?
      for i in (0...size)
        yield(i, self[i])
      end
    else
      to_enum
    end
  end

  def my_select
    if block_given?

      arr = []
      my_each do |element|
        arr << element if yield(element)
      end
      arr
    else
      to_a
    end
  end

  def my_all?(arg = nil)
    response = true
    if block_given?
      my_each do |element|
        response = false unless yield(element)
      end

    elsif !arg.nil?
      my_each do |element|
        response = false unless element.is_a?(arg)
      end

    else
      response = true
    end
    response
  end

  def my_any?(arg = nil)
    response = false
    if block_given?
      my_each do |element|
        response = true if yield(element)
      end

    elsif !arg.nil?
      my_each do |element|
        response = true if element.is_a?(arg)
      end

    else
      response = true
    end
    response
  end

  def my_none?(arg = nil)
    response = false
    if block_given?
      my_each do |element|
        response = true if yield(element)
      end

    elsif !arg.nil?
      my_each do |element|
        response = true unless element.is_a?(arg)
      end
    else
      response = true
    end
    response
  end

  def my_count(count = 0)
    if block_given?
      my_each do |element|
        count += 1 if yield(element)
      end

    elsif !count.eql?(0)
      count += size

    else
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
      arr = to_a

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
      to_enum
    end
    acum
  end

  def my_multiply()
    my_inject(:*)
  end
end
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Style/For
