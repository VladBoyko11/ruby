def is_balanced (str = '')
  start_str = "{(["
  endStr = "})]"
  queue = Array[]
  hash = {
  "}"=> "{",
  ")"=> "(",
  "]"=> "[",
  }
  str.split('').each do |char|
    if start_str.include?(char)
      queue.push(char)
    elsif endStr.include?(char)
      # puts queue.join(' ')
      last = queue.pop()
      # puts queue.join(' ')
      # puts hash[char]
      if hash[char] != last
        return false
      end
    end
  end
  queue.length == 0
end

puts is_balanced("(x+y) - 2 + (5)") # true
puts is_balanced("((x+y) - 2 + (5)") # false
puts is_balanced("(){}[]") # true
puts is_balanced("[(])") # false
puts is_balanced("[({})](]") # false