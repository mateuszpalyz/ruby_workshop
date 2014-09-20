require 'minitest/autorun'
require './money'

class MoneyTest < Minitest::Test
  def setup
    @money = Money.new(10, "USD")
  end

  def test_to_s_usage
    assert_equal "10.00 USD", @money.to_s
  end

  def test_inspect_usage
    assert_equal "#<Money 10.00 USD>", @money.inspect
  end
end
