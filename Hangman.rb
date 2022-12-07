words = Array["application", "programming", "developer", "ruby", "interface", "array", "frontend"]
selected_word = words[rand(words.length)].split('')

correct_letters = Array.new(selected_word.length, '*')
puts selected_word.join(' ')
wrong_letters = Array[]

while wrong_letters.length < 6 do
  puts 'Введите букву'
  letter = STDIN.gets.chomp.downcase
  if letter.length > 1 || !/[a-z]/.match?(letter)
    puts 'Введите одну букву!'
    next
  elsif correct_letters.include?(letter) || wrong_letters.include?(letter)
    puts 'Вы уже вводили эту букву'
    next
  end

  if selected_word.include?(letter)
    (0..selected_word.length).each { |i|
      if selected_word[i] == letter
        correct_letters[i] = letter
      end
    }
    if selected_word.join('') == correct_letters.join('')
      puts "Вы отгадали слово! Это было слово #{ correct_letters.join('') }"
      return
    end
    puts correct_letters.join(' ')
  else
    wrong_letters.push(letter)
    if wrong_letters.length == 6
      puts "Вы проиграли. Правильное слово - #{selected_word.join('')}"
      puts 'Неподходящие буквы'
      puts wrong_letters.join(' ')
    else
      puts 'Неподходящие буквы'
      puts wrong_letters.join(' ')
    end
  end
end
