def frequentlyWords(str = '')
  arrWords = str.gsub(/[,#\\\. \/"«»]/,' ').downcase.split(' ')

  hash = Hash.new
  (0..(arrWords.length - 1)).each do |i|
    if hash.has_key?(arrWords[i])
      hash.store(arrWords[i], hash[arrWords[i]].to_i + 1)
    else
      hash.store(arrWords[i], 1)
    end
  end
  hash = hash.sort{|a,b| b[1]<=>a[1]}.to_h
  hash = hash.slice(hash.keys[0], hash.keys[1], hash.keys[2]).to_h
  return hash
end

puts frequentlyWords("«ABC, ABC», «ABC», AB'C")
puts frequentlyWords("In a village of La Mancha, the name of which I have no desire to call to
mind, there lived not long since one of those gentlemen that keep a lance
in the lance-rack, an old buckler, a lean hack, and a greyhound for
coursing. An olla of rather more beef than mutton, a salad on most
nights, scraps on Saturdays, lentils on Fridays, and a pigeon or so extra
on Sundays, made away with three-quarters of his income.")