require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customers

  def setup
    @customers = CustomerRepository.new(SalesEngine.new)
  end

  def test_it_returns_all_items
    results = customers.all
    assert_equal 1000, customers.all.count
  end

  def test_it_returns_a_random_element
    assert_instance_of Customer, customers.random
  end

  def test_you_can_find_by_id
    results = customers.find_by_id("1")
    assert_equal "Joey", results.first_name
  end

  def test_you_can_find_by_first_name
    results = customers.find_by_first_name("Joey")
    assert_equal "1", results.id
  end

  def test_you_can_find_by_last_name
    results = customers.find_by_last_name("Ondricka")
    assert_equal "1", results.id
  end

end
