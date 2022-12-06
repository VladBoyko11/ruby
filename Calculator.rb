puts 'Первое число:'
number1 = STDIN.gets.chomp.to_i
puts 'Второе число:'
number2 = STDIN.gets.chomp.to_i

puts 'Выберите операцию (+ - * /)'
operation = STDIN.gets.chomp

puts 'Результат:'
case operation
when '+'
  puts number1 + number2
when '-'
  puts number1 - number2
when '*'
  puts number1 * number2
when '/'
  begin
    puts number1 / number2
  rescue ZeroDivisionError
    puts 'На ноль делить нельзя'
  end
else
  puts 'Нет такой операции'
end