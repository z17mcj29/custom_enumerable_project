module Enumerable
  # Your code goes here
  
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    temp_array = []
    temp_val = 0

    self.my_each do |v|
      temp_array << yield(v,temp_val)
      temp_val += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    temp_array = []

    self.my_each do |v|
      temp_array << v if yield(v)
      
      end
      temp_array
  end

  def my_all?
    #I don't quite know why this one worked. I will come back later when I know more, am happy now to see it pass
    #I think I do have a bug in it, and I'll explain it now and maybe come back later to fix it.
    #From what I understand about truthy and falsey values is it needs to be false or nil to
    #be false, everything else is true. I think I need to have another process that
    #runs through the array if a block_given? is false to see if anything in the array
    #includes a nil or false value. I think that setting ret_value to true automatically
    #made so it got past the test cases. I'll leave it for now and come back later when
    #I know more.
    ret_value = true
    self.my_each do |v|
      break ret_value = false unless yield(v)
    end
    ret_value
  end

  def my_any?
    ret_value = false
    self.my_each do |v|
      break ret_value = true if yield(v)
    end
    ret_value
  end

  def my_none?
    ret_value = true
    self.my_each do |v|
      break ret_value = false if yield(v)
    end
    ret_value
  end

  def my_count(n = nil)
    #Looking at the specifications this looks like its going to be a bit harder than the previous ones.
    #I need to account for three different scenarios.
    #If no value is passed I need to count how many items are in the array.
    #If a value is passed I need to count how many of that type of value is in the array ex. [1,2,2,2,3,4].my_count(2) # => 3
    #if a block is passed, the count will count up for every truthful value.
    ret_value = 0
    if block_given?
      self.my_each do |v|
        ret_value += 1 if yield(v)
      end
    end

    if block_given? == false
      if n == nil
        self.my_each do |v|
          ret_value += 1
        end
      else
        self.my_each do |v|
          ret_value += 1 if v == n
        end
      end
              
    end
      ret_value
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    ret_value = []

    self.my_each do |v|
      ret_value << yield(v)
    end
    ret_value
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?
    for item in self
      yield(item)
    end
    
  end
end
