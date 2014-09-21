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
    Exchange.any_instance.stubs(:calculate).returns(32.5)
    assert_equal 32.5, Money.exchange.convert(@money, "PLN")
  end

  def test_exchange_to_usage
    Exchange.any_instance.stubs(:calculate).returns(32.5)
    assert_equal 32.5, @money.exchange_to("PLN")
  end

  def test_invalid_currency_error
    exception = assert_raises(Exchange::InvalidCurrency) { @money.exchange_to("XYZ") }
    assert_equal "Invalid currency: XYZ", exception.message
  end

  def test_money_comparison_operator_when_equal
    Exchange.any_instance.stubs(:fetch_exchange_rate).returns(1)
    assert @money == Money(10, "USD")
  end

  def test_money_comparison_operator_when_differ
    Exchange.any_instance.stubs(:fetch_exchange_rate).returns(0.3)
    assert @money > Money(10, "PLN")
  end

  def test_money_ranges
    case @money
      when Money(20, "PLN")..Money(30, "PLN") then test = "fail"
      when Money(30, "PLN")..Money(40, "PLN") then test = "OK"
      when Money(40, "PLN")..Money(50, "PLN") then test = "fail"
    end

    assert_equal "OK", test
  end

  def test_method_missing_for_exisitng_currency
    Exchange.any_instance.stubs(:calculate).returns(32.5)
    assert_equal 32.5, @money.to_pln
  end

  def test_method_missing_for_non_exisitng_currency
    assert_raises(NoMethodError) { @money.to_xyz }
  end

  def test_respond_to_for_exisitng_currency
    assert @money.respond_to?(:to_pln)
  end

  def test_respond_to_for_non_exisitng_currency
    refute @money.respond_to?(:to_xyz)
  end
end
