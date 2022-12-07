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

def methodNeyman (a, b, c ,d)
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

def methodMetropolis(a, b, c, d)
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

def methodInverseFunction(a, b, c, d)
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


resMethodNeyman = methodNeyman(@a, @b, @c, @d)
resMethodMetropolis = methodMetropolis(@a, @b, @c, @d)
resMethodInverseFunction = methodInverseFunction(@a, @b, @c, @d)
resSimplest_monte_carlo = simplest_monte_carlo(@a, @b, @c, @d)
file = File.new("file.txt", "a:UTF-8")
file.print("Умови інтегрування наступні: \n")
file.print("Область інтегрування: #{@a} <= #{@b} <= #{@c} <= #{@d} \n")
file.print("Кількість обчислень для статистичних методів: #{@quantity} \n")
file.print("Метод Неймана: #{resMethodNeyman}\n")
file.print("Метод Метрополісу: #{resMethodMetropolis}\n")
file.print("Метод зворотної функції: #{resMethodInverseFunction}\n")
file.print("Найпростіший метод Монте Карло: #{resSimplest_monte_carlo}\n")
file.print("Крок для детерміністичних методів: #{@step}\n")
file.print("Час обчислення (1): #{methodNeyman(@a, @b, @c, @d).real} c\n")
file.print("Час обчислення (2): #{methodMetropolis(@a, @b, @c, @d).real} c\n")
file.print("Час обчислення (3): #{methodInverseFunction(@a, @b, @c, @d).real} c\n")
file.print("Час обчислення (4): #{simplest_monte_carlo(@a, @b, @c, @d).real} c\n")

puts "Умови інтегрування наступні: \n
Область інтегрування: #{@a} <= #{@b} <= #{@c} <= #{@d}
Кількість обчислень для статистичних методів: #{@quantity}"


puts "Метод Неймана: #{resMethodNeyman}"
puts "Метод Метрополісу: #{resMethodMetropolis}"
puts "Метод зворотної функції: #{resMethodInverseFunction}"
puts "Найпростіший метод Монте Карло: #{resSimplest_monte_carlo}"

puts "Крок для детерміністичних методів: #{@step}"
puts "Час обчислення (1): #{methodNeyman(@a, @b, @c, @d).real} c"
puts "Час обчислення (2): #{methodMetropolis(@a, @b, @c, @d).real} c"
puts "Час обчислення (3): #{methodInverseFunction(@a, @b, @c, @d).real} c"
puts "Час обчислення (4): #{simplest_monte_carlo(@a, @b, @c, @d).real} c"


