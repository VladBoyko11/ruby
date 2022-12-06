def isBalanced (str = '')
  startStr = "{(["
  endStr = "})]"
  queue = Array[]
  map = {
  "}"=> "{",
  ")"=> "(",
  "]"=> "[",
  }
  str.split('').each do |char|
    if startStr.include?(char)
      queue.push(char)
    elsif endStr.include?(char)
      puts queue.join(' ')
      last = queue.pop()
      puts queue.join(' ')
      puts map[char]
      if map[char] != last
        return false
      end
    end
  end
  return queue.length == 0
end

puts isBalanced("(x+y) - 2 + (5)") # true
puts isBalanced("((x+y) - 2 + (5)") # false
puts isBalanced("(){}[]") # true
puts isBalanced("[(])") # false
puts isBalanced("[({})](]") # false