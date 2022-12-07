def get_string_number(expr = '', pos)
  str_number = ''
  if expr.length == 1
    return [expr, pos]
  end
  expr.each_char do |char|
    if char.match?(/\d/)
      str_number += char
      pos += 1
    else
      return [str_number, pos - 1]
    end
  end
end

def to_polish_notation(str = '')
  stack = []
  postfix_expr = ''
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
      arr = get_string_number(str.slice(index, str.length), index)
      postfix_expr += ' ' + arr[0]
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
          postfix_expr += ' ' + to_polish_notation(expr)
        else
          expr += str[index]
        end
      end
    elsif hash.keys.include?(str[index])
      postfix_expr = str[index] + ' ' + postfix_expr
    end
    index += 1
  end
  postfix_expr
end

# def calc_polish_notation(str = '')
#   stack = []
#   res = 0
#   hash = {
#     '(' => 0,
#     '+' => 1,
#     '-' => 1,
#     '*' => 2,
#     '/' => 2,
#     '^' => 3,
#   }
#   str.each_char do|char|
#     if stack.length > 0 && char.to_i && stack[stack.length - 1].to_i
#       num1 = stack.pop
#       operation = stack.pop
#       num2 = char
#       case operation
#       when '+'
#         res = num1 + num2
#       when '-'
#         res = num1 - num2
#       when '/'
#         res = num1 / num2
#       when '*'
#         res = num1 * num2
#       when '^'
#         res = num1 ^ num2
#       end
#
#       if stack[stack.length - 1].to_i
#         calcPolishNotation(stack.join(' ') + res)
#       end
#     else
#       stack.push(char)
#     end
#   end
#   return res
# end

puts to_polish_notation('15 / (7 - (1 + 1)) * 3 - (2 + (1 + 1))') #  - * / 15 - 7 + 1 1 3 + 2 + 1 1
# puts calcPolishNotation(toPolishNotation('15 / (7 - (1 + 1)) * 3 - (2 + (1 + 1))'))
puts to_polish_notation('7+2') # + 7 2
puts to_polish_notation('5 * (9 + 3)') # * (+ 9 3) 5
puts to_polish_notation('19^2') # ^ 19 2