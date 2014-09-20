require 'minitest/autorun'
require 'mocha/mini_test'
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

  def test_exchange_convert_usage
    Exchange.any_instance.stubs(:fetch_exchange_rate).returns(3.25)
    assert_equal 32.5, Money.exchange.convert(@money, "PLN")
  end

  def test_exchange_to_usage
    Exchange.any_instance.stubs(:fetch_exchange_rate).returns(3.25)
    assert_equal 32.5, @money.exchange_to("PLN")
  end

  def test_invalid_currency_error
    exception = assert_raises(Exchange::InvalidCurrency) { @money.exchange_to("XYZ") }
    assert_equal "Invalid currency: XYZ", exception.message
  end
end
