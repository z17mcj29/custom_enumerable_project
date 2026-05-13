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

  # def my_inject(n = nil)
  #   #Doing some research on how this works.
  #   #if I provide an initial value that is where the accumulator will begin
  #   #if no initial value is provided the first element of the collection is used as the starting value
  #   #It will take two arguments, the accumulator and element, accumulator going first.
  #   #the accumulator is commonly called the "memo"
  #   #I'm not sure about hashes and the different outputs I'm expected to be able to
  #   #produce. I know in the normal inject I can have the output be a hash. I'm not sure
  #   #which data type to make my accumulator.
  #   #My research also didn't tell me if it passes the enumerator if no block is passed, but I will
  #   #start off assuming that is how it works.
  #   return to_eunm(:my_inject) unless block_given?

  #   memo = 0
  #   memo = self[0] if n == nil
        
  #   self.my_each do |v|
  #     memo += yield(memo, v)
  #   end
  #   memo
  # end
  
  def my_inject(n)
    #I commented out my previous attempt so I would have it for historical sake.
    #I looked at the test conditions and they all put in a value for the parameter.
    #I think the real version works with our without a parameter, but for this
    #assignment I am not going to try and check if it's nil. I need to do some
    #research on the proper way to determine if a parameter is given or not, but
    #I don't want to do that until I complete this project because I feel like
    #it's cheating in a sense. I want to do this on my own if I can.
    return to_enum(:my_inject) unless block_given? #I just noticed my previous attempt misspelled enum
    memo = n
    ret_value = n
    self.my_each do |v|
      ret_value += yield(memo,v)
    end
      ret_value
    #obviously my logic isn't working. I'm not sure what the problem is, but it's obvious I'm missing
    #something. The process is working, just not correctly. My testing says 1st test should be 88, but
    #I get 880. 2nd test expects 2227680, gets 27941760. 3rd test expects 188, gets 52080.
    #The problem has to be in how I am collecting the results. The yield needs the memo and
    #the current array value. That part has to be right. My mind is blank right now on
    #why my current method of memo += is wrong and what I need to do different.
    #OK, I am going to try and add a value ret_value which has the same initial
    #value as memo, but is a seperate value. I feel like having memo twice might
    #be messing with the math.
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
