def getStringNumber(expr = '', pos)
  strNumber = ''
  if expr.length == 1
    return [expr, pos]
  end
  expr.each_char do |char|
    if char.match?(/\d/)
      strNumber += char
      pos += 1
    else
      return [strNumber, pos - 1]
    end
  end
end

def toPolishNotation(str = '')
  stack = []
  prefixExpr = ''
  index = 0
  hash = {
    '(' => 0,
    '+' => 1,
    '-' => 1,
    '*' => 2,
    '/' => 2,
    '^' => 3,
  }
  while index < str.length do
    if str[index].match?(/\d/)
      arr = getStringNumber(str.slice(index, str.length), index)
      prefixExpr += ' ' + arr[0]
      index = arr[1]
    elsif str[index] == '('
      stack.push(str[index])
      expr = ''
      while stack.length > 0
        index += 1
        str[index] = str[index]
        if str[index] == '('
          stack.push(str[index])
          if stack.length > 1
            expr += str[index]
            next
          end
        elsif str[index] == ')'
          stack.pop
          if stack.length > 0
            expr += str[index]
            next
          end
          prefixExpr += ' ' + toPolishNotation(expr)
        else
          expr += str[index]
        end
      end
    elsif hash.keys.include?(str[index])
      prefixExpr = str[index] + ' ' + prefixExpr
    end
    index += 1
  end
  return prefixExpr
end

def calcPolishNotation(str = '')
  stack = []
  res = 0
  hash = {
    '(' => 0,
    '+' => 1,
    '-' => 1,
    '*' => 2,
    '/' => 2,
    '^' => 3,
  }
  str.each_char do|char|
    if stack.length > 0 && char.to_i && stack[stack.length - 1].to_i
      num1 = stack.pop
      operation = stack.pop
      num2 = char
      case operation
      when '+'
        res = num1 + num2
      when '-'
        res = num1 - num2
      when '/'
        res = num1 / num2
      when '*'
        res = num1 * num2
      when '^'
        res = num1 ^ num2
      end

      if stack[stack.length - 1].to_i
        calcPolishNotation(stack.join(' ') + res)
      end
    else
      stack.push(char)
    end
  end
  return res
end

puts toPolishNotation('15 / (7 - (1 + 1)) * 3 - (2 + (1 + 1))') #  - * / 15 - 7 + 1 1 3 + 2 + 1 1
# puts calcPolishNotation(toPolishNotation('15 / (7 - (1 + 1)) * 3 - (2 + (1 + 1))'))
puts toPolishNotation('7+2') # + 7 2
puts toPolishNotation('5 * (9 + 3)') # * (+ 9 3) 5
puts toPolishNotation('19^2') # ^ 19 2