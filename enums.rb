# rubocop:disable Style/For
module Enumerables
  def my_each
    return unless block_given?

    for element in self
      yield(element)
  end
  end

  def my_each_with_index
    return unless block_given?

    for i in (0...size)
      yield(i, self[i])
end
  end

  def my_select
    if block_given?
      arr = []
      my_each do |element|
        arr << element if yield(element)
      end
    end
    arr
  end

  def my_all?
    if block_given?
      response = true
      my_each do |element|
        response = false unless yield(element)
      end
    end
    response
  end

  def my_any?
    if block_given?
      response = false
      my_each do |element|
        response = true if yield(element)
      end
    end
    response
  end

  def my_none?
    if block_given?
      response = false
      my_each do |element|
        response = true if yield(element)
      end
    end
    response
  end

  def my_count
    if block_given?
      count = 0
      my_each do |element|
        count += 1 if yield(element)
      end
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
    end
    acum
  end

  def my_multiply()
    my_inject(:*)
  end
end
# rubocop:enable Style/For
