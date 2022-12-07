def alphabet_position (str = '')
  alphabet = ("a".."z").to_a
  arr_str = str.gsub(/\W/,'').downcase.split('')
  result = ''
  arr_str.each do |letter|
    result += (alphabet.index(letter) + 1).to_s + ' '
  end
  result
end

puts alphabet_position("The sunset sets at twelve o' clock.")