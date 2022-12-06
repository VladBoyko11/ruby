def alphabet_position (str = '')
  alphabet = ("a".."z").to_a
  arrStr = str.gsub(/\W/,'').downcase.split('')
  result = ''
  arrStr.each do |letter|
    result += (alphabet.index(letter) + 1).to_s + ' '
  end
  return result
end

puts alphabet_position("The sunset sets at twelve o' clock.")