require 'benchmark'

@a = 0
@b = 0.9
@c = 1.5
@d = 2.1

@step = 0.0001
@quantity = 10_000

def trapezoidal_distribution (x, a, b, c, d)
  if x >= a && x < b
    return 2/(d + c - b - a) * (x - a) / (b - a)
  elsif x >= b && x < c
    return 2/(d + c - b - a)
  elsif x >= c && x < d
    return 2/(d + c - b - a) * (d - x) / (d - c)
  end
end

def method_neyman (a, b, c ,d)
  @W = 0
  (1..@quantity).each { |i|
    @Ti = trapezoidal_distribution(i / @quantity, a, b, c ,d)
    if @Ti > @W
      @W = @Ti
    end
  }
  while(true)
    y1 = rand(a.to_f..d.to_f)
    y2 = rand(a.to_f..d.to_f)
    x = y1
    y=@W*y2
    if trapezoidal_distribution(x, a, b, c ,d) > y
      return x
    end
  end
end

def method_metropolis(a, b, c, d)
  (1..@quantity).each { |i|
    @x0 = 0.5
    @del = 0.2
    @x = @x0 + (-1 + 2 * rand) * @del
    if @x > 0 && @x < 1
      t = trapezoidal_distribution(@x, a, b, c, d) / trapezoidal_distribution(@x0, a, b, c, d)
    else
      t = 0
    end
    if t >= 1
      @x0 = @x
    elsif rand < t
      @x0 = @x
    end
  }
  return @x0
end

def method_inverse_function(a, b, c, d)
  num1 = 2 + d * (d + c - b - a)*(d - c)
  num = 2 * num1 / (d + c - b - a)*(d - c)
  return Math.sqrt(num)
end

def simplest_monte_carlo (a, b, c, d)
  sum = 0
  (1...@quantity).each {
    sum += trapezoidal_distribution(rand(a.to_f...d.to_f), a, b, c, d)
  }
  sum / @quantity
end

# def resMethodNeyman2 (x)
#   @W = 0
#   (1..@quantity).each { |i|
#     @Ti = trapezoidal_distribution(x, @a, @b, @c ,@d)
#     if @Ti > @W
#       @W = @Ti
#     end
#   }
#   while(true)
#     y1 = rand(0.to_f...x.to_f)
#     y2 = rand(0.to_f...x.to_f)
#     x = y1
#     y=@W*y2
#     if trapezoidal_distribution(x, @a, @b, @c ,@d) > y
#       return x
#     end
#   end
# end

# @min = 0.1
# @max = 1


res_method_neyman = method_neyman(@a, @b, @c, @d)
res_method_metropolis = method_metropolis(@a, @b, @c, @d)
res_method_inverse_function = method_inverse_function(@a, @b, @c, @d)
res_simplest_monte_carlo = simplest_monte_carlo(@a, @b, @c, @d)

file = File.new("#{__dir__}/file.txt", "a:UTF-8")
file.print("Умови інтегрування наступні: \n")
file.print("Область інтегрування: #{@a} <= #{@b} <= #{@c} <= #{@d} \n")
file.print("Кількість обчислень для статистичних методів: #{@quantity} \n")
file.print("Метод Неймана: #{res_method_neyman}\n")
file.print("Метод Метрополісу: #{res_method_metropolis}\n")
file.print("Метод зворотної функції: #{res_method_inverse_function}\n")
file.print("Найпростіший метод Монте Карло: #{res_simplest_monte_carlo}\n")
file.print("Крок для детерміністичних методів: #{@step}\n")
file.print("Час обчислення (1): #{method_neyman(@a, @b, @c, @d).real} c\n")
file.print("Час обчислення (2): #{method_metropolis(@a, @b, @c, @d).real} c\n")
file.print("Час обчислення (3): #{method_inverse_function(@a, @b, @c, @d).real} c\n")
file.print("Час обчислення (4): #{simplest_monte_carlo(@a, @b, @c, @d).real} c\n")
file.close

puts "Умови інтегрування наступні: \n
Область інтегрування: #{@a} <= #{@b} <= #{@c} <= #{@d}
Кількість обчислень для статистичних методів: #{@quantity}"


puts "Метод Неймана: #{res_method_neyman}"
puts "Метод Метрополісу: #{res_method_metropolis}"
puts "Метод зворотної функції: #{res_method_inverse_function}"
puts "Найпростіший метод Монте Карло: #{res_simplest_monte_carlo}"

puts "Крок для детерміністичних методів: #{@step}"
puts "Час обчислення (1): #{method_neyman(@a, @b, @c, @d).real} c"
puts "Час обчислення (2): #{method_metropolis(@a, @b, @c, @d).real} c"
puts "Час обчислення (3): #{method_inverse_function(@a, @b, @c, @d).real} c"
puts "Час обчислення (4): #{simplest_monte_carlo(@a, @b, @c, @d).real} c"


