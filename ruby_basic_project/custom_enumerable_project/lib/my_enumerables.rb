module Enumerable
  # Your code goes here
  def my_each
    if block_given?
      for el in self
        yield(el)
      end
    else
      puts 'there is no block!!!'
    end
  end

  def my_each_with_index
    if block_given?
      index = 0
      for el in self
        yield(el, index)
        index += 1
      end
    else
      puts 'there is no block!!!'
    end
  end

  def my_map(&my_block)
    if block_given?
      result = []
      for el in self
        result << my_block.call(el)
      end
      result
    else
      puts 'there is no block!!!'
    end
  end

  def my_select
    if block_given?
      result = []
      my_each { |element| result.push(element) if yield(element) }
      result
    else
      puts 'there is no block!!!'
    end
  end

  def my_all?
    if block_given?
      my_each { |element| return false unless yield(element) }
      true
    else
      puts 'there is no block!!!'
    end
  end

  def my_any?
    if block_given?
      my_each { |element| return true if yield(element) }
      false
    else
      puts 'there is no block!!!'
    end
  end

  def my_none?
    if block_given?
      my_each { |element| return false if yield(element) }
      true
    else
      puts 'there is no block!!!'
    end
  end

  def my_count
    count = 0
    if block_given?
      my_each { |element| count += 1 if yield(element) }
      count
    else
      puts 'there is no block!!!'
      my_each { |_element| count += 1 }
      count
    end
  end

  def my_inject(accumulator = nil, &block)
    arr = instance_of?(Range) ? to_a : self
    if block_given?
      if accumulator.nil?
        accumulator = first
        for i in 0..arr.size - 2
          accumulator = block.call(accumulator, arr[i + 1])
        end
      elsif accumulator
        for i in 0..arr.size - 1
          accumulator = block.call(accumulator, arr[i])
        end
      end
    end
    accumulator
  end
end

class Array
  include Enumerable
end
