def stock_picker(prices)
    min_buy = prices[0]
    min_buy_index = 0
    max_profit = 0
    result = [0, 0]
    
    for i in 1 ... prices.length
        if prices[i] < min_buy
            min_buy = prices[i]
            min_buy_index = i
        end
        value = prices[i] - min_buy
        if max_profit < value
            max_profit = value
            result = [min_buy_index, i]
        end
    end
    result
end
p stock_picker([17,3,6,9,15,8,6,1,10])


