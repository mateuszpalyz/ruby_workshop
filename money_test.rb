require 'minitest/autorun'
require './money'
require './object'

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

  def test_from_usd_usage
    assert_equal "#<Money 10.00 USD>", Money.from_usd(10).inspect
  end

  def test_from_eur_usage
    assert_equal "#<Money 10.00 EUR>", Money.from_eur(10).inspect
  end

  def test_from_gbp_usage
    assert_equal "#<Money 10.00 GBP>", Money.from_gbp(10).inspect
  end

  def test_Money_usage
    assert_equal "#<Money 10.00 USD>", Money(10, "USD").inspect
  end
end
