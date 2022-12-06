words = Array["application", "programming", "developer", "ruby", "interface"]
selectedWord = words[rand(words.length)].split('')

correctLetters = Array.new(selectedWord.length, '*')
puts selectedWord.join(' ')
wrongLetters = Array[]

while wrongLetters.length < 6 do
  puts 'Введите букву'
  letter = STDIN.gets.chomp.downcase
  if letter.length > 1 and /[a-z]/.match?(letter)
    puts 'Введите одну букву!'
    next
  elsif correctLetters.include?(letter) || wrongLetters.include?(letter)
    puts 'Вы уже вводили эту букву'
    next
  end

  if selectedWord.include?(letter)
    (0..selectedWord.length).each { |i|
      if selectedWord[i] == letter
        correctLetters[i] = letter
      end
    }
    if selectedWord.join('') == correctLetters.join('')
      puts "Вы отгадали слово! Это было слово #{ correctLetters.join('') }"
      return
    end
    puts correctLetters.join(' ')
  else
    wrongLetters.push(letter)
    if wrongLetters.length == 6
      puts "Вы проиграли. Правильное слово - #{selectedWord.join('')}"
    else
      puts 'Неподходящие буквы'
      puts wrongLetters.join(' ')
    end
  end
end
