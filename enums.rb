# rubocop:disable Style/For
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
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

        yield(self[i], i)
      end
      to_a
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
      to_enum
    end
  end

  def my_all?(arg = nil)
    response = true
    if block_given?
      my_each do |element|
        response = false unless yield(element)
      end

    elsif !arg.nil?

      if arg.is_a? Class
        my_each do |element|
          response = false unless element.is_a?(arg)
        end
      elsif arg.is_a? Regexp
        my_each do |element|
          response = false unless element.to_s.match(arg)
        end

      else
        my_each do |element|
          response = false unless element.eql?(arg)
        end
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
      if arg.is_a? Class
        my_each do |element|
          response = true if element.is_a?(arg)
        end
      elsif arg.is_a? Regexp
        my_each do |element|
          response = true if element.to_s.match(arg)
        end

      else
        my_each do |element|
          response = true if element.eql?(arg)
        end
      end

    else
      response = false
      my_each do |element|
        response = true if element
      end
    end
    response
  end

  def my_none?(arg = nil)
    response = true
    if block_given?
      response = true
      my_each do |element|
        response = false if yield(element)
      end

    elsif !arg.nil?

      if arg.is_a? Class
        my_each do |element|
          response = false if element.is_a?(arg)
        end
      elsif arg.is_a? Regexp
        my_each do |element|
          response = false if element.to_s.match(arg)
        end

      else

        my_each do |element|
          response = false if element.eql?(arg)
        end
      end
    else
      response = true
      my_each do |element|
        response = false if element
      end
    end
    response
  end

  def my_count(*arg)
    count = 0
    if block_given?
      my_each do |element|
        count += 1 if yield(element)
      end

    elsif !arg[0].nil?
      my_each do |element|
        count += 1 if element.eql?(arg[0])
      end
      return count

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
      return to_enum
    end
    arr
  end

  def my_inject(* args)
    to_a if is_a? Range
    if args[0].equal?(:+) and args[1].nil?
      acum = 0
      my_each do |element|
        acum += element
      end
      acum
    elsif args[0].equal?(:*) and args[1].nil?
      acum = 1
      my_each do |element|
        acum *= element
      end
      acum
    elsif args[0].is_a? Numeric and args[1].equal?(:+)
      acum = args[0]
      my_each do |element|
        acum += element
      end
      acum

    elsif args[0].is_a? Numeric and args[1].equal?(:*)
      acum = args[0]
      my_each do |element|
        acum *= element
      end
      acum

    elsif block_given? and !args[0].nil?
      acum = args[0]
      my_each do |element|
        acum = yield(acum, element)
      end
      acum

    elsif block_given? and args.size.eql?(0)
      if is_a? Range
        arr = to_a
        acum = arr[0]
      else
        acum = self[0]
      end
      acum = 0 unless acum.is_a? String
      my_each do |element|
        acum = yield(acum, element)
      end
      acum
    else
      to_enum
    end
  end

  def my_multiply()
    my_inject(:*)
  end
end
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Style/For
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
