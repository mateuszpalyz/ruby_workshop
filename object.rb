def Money(amount, currency)
  Money.new(amount, currency)
end

def Rate(from, to)
  Rate.rates.each do |rate|
    if rate.from == from and rate.to == to
      return rate
    end
  end
  Rate.new(from, to)
end
