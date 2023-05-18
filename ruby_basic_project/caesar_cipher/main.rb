def caesar_cipher(string, factor)
    # 65 -> 90 A: Z
    # 97 -> 122 a: z
    fx = factor % 26
    p fx
    convert_string_ord = string.split("").map { |a| a.ord }
    p convert_string_ord
    caesar_ord = convert_string_ord.map do |s|
        if 65 <= s && s <= 90
            s + fx > 90 ? s + fx - 26 : s + fx
        elsif 97 <=s && s <= 122
            s + fx > 122 ? s + fx - 26: s + fx
        else
            s
        end
    end 
    p caesar_ord
    caesar_ord.map {|o| o.chr }.join("")
end


puts caesar_cipher("What a string!", 5)