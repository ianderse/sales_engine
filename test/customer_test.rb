require 'csv'
require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
  attr_reader :customers, :customer

  def setup
    @engine = SalesEngine.new
    customer_attributes = [{id: 1, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}]
    @customers = CustomerRepository.new(@engine, customer_attributes)
    @customer = customers.all.first
  end

  def test_it_returns_a_first_name
    assert_equal "Joey", customer.first_name
  end

  def test_it_returns_a_last_name
    assert_equal "Ondricka", customer.last_name
  end

  def test_it_returns_an_id
    assert_equal 1, customer.id
  end

  def test_it_returns_an_updated_at
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at
  end

  def test_it_returns_created_at
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at
  end

end
