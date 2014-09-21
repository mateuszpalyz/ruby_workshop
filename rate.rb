require 'json'
require 'net/http'

class Rate
  @@rates = []
  attr_reader :from, :to

  def initialize(from, to)
    @from = from
    @to = to
    fetch
    @@rates << self
  end

  def fetch
    url = "http://rate-exchange.appspot.com/currency?from=#{@from}&to=#{@to}"
    response = Net::HTTP.get_response(URI.parse(url))
    data = response.body
    @multiplier = JSON.parse(data)["rate"]
    @time_stamp = Time.now
  end

  def outdated?
    Time.now - @time_stamp > 86400 ? true : false
  end

  def get_multiplier
    outdated? ? fetch : @multiplier
  end

  def self.rates
    @@rates
  end
end
