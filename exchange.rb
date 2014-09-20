require 'json'
require 'net/http'

class Exchange
  @@currencies = ["USD", "EUR", "GBP", "CHF", "JPY", "PLN"]

  def convert(money, currency)
    raise InvalidCurrency, "Invalid currency: #{currency}"       unless @@currencies.include? currency
    raise InvalidCurrency, "Invalid currency: #{money.currency}" unless @@currencies.include? money.currency
    rate = fetch_exchange_rate(money.currency, currency)
    send("convert_to_#{currency}", money.amount, rate)
  end

  @@currencies.each do |currency|
    define_method "convert_to_#{currency}" do |amount, rate|
      amount * rate
    end
  end

  def fetch_exchange_rate(from, to)
    url = "http://rate-exchange.appspot.com/currency?from=#{from}&to=#{to}"
    response = Net::HTTP.get_response(URI.parse(url))
    data = response.body
    JSON.parse(data)["rate"]
  end

  class InvalidCurrency < StandardError; end
end
