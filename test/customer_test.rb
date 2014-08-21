require 'csv'
require_relative 'test_helper'
require_relative '../lib/csv_handler'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
  attr_reader :customers, :customer

  def setup
    @engine = SalesEngine.new
    @engine.startup
    csv        = CsvHandler.new("./data/customers.csv")
    @customers = csv.data.collect {|row| Customer.new(row, @engine.customer_repository)}
    @customer = customers.first
  end

  def test_it_returns_a_first_name
    assert_equal "Joey", customer.first_name
  end

  def test_it_returns_a_last_name
    assert_equal "Ondricka", customer.last_name
  end

  def test_it_returns_an_id
    assert_equal "1", customer.id
  end

  def test_it_returns_an_updated_at
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at
  end

  def test_it_returns_created_at
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at
  end

  def test_it_returns_all_associated_invoices
    assert_equal 8, customer.invoices.size
  end

  def test_it_returns_an_array_of_a_customers_tranactions
    assert_equal 8, customer.transactions.count
  end

  def test_favorite_merchant_returns_merchant_with_most_successful_tranactions
    skip
    assert_equal 11, customer.favorite_merchant
  end
end
