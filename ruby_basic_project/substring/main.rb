def substring(string, dictionary)
    lower_text = string.downcase
    result  = dictionary.reduce(Hash.new(0)) do |hash, word|
        matches = lower_text.scan(word).length
        hash[word] = matches
        hash
    end
    p result
    result.select {|key, value| value > 0}
end
