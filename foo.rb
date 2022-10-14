def calculate(a,b, *x)
  if x.is_a?(Hash)
    return subtract(a,b) if x[:subtract] == true
  end

  if(x.is_a?(Array))
    new_arr = [a,b]
    option = {}
    x.each do |item|
      new_arr << item if !item.is_a?(Hash)
      option = item if item.is_a?(Hash)
    end
    return subtract(*new_arr) if option[:subtract] == true
    return add(*new_arr)

  end


  return add(a,b)
end

def add(*n3)
  n3.inject(0) { |sum, i| sum + i }
end

def subtract(n1, n2, *n3 )
  n1 - n2 - n3.inject(0) { |sum, i| sum + i }
end
