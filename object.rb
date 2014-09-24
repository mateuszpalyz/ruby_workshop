def Money(*args)
  Money.new(*args)
end

def Rate(from, to)
  Rate.rates.each do |rate|
    if rate.from == from && rate.to == to
      return rate.get_multiplier
    end
  end
  Rate.new(from, to).get_multiplier
end
