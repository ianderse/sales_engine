require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :repository

  def setup
    @repository = InvoiceItemRepository.new(SalesEngine.new)
  end

  def test_it_can_return_all
    assert_equal 21687, repository.all.count
  end

  def test_it_can_return_a_random_instance
    assert_instance_of InvoiceItem, repository.random
  end

  def test_it_finds_by_id
    results = repository.find_by_id("1")
    assert_equal "1", results.invoice_id
  end

  def test_it_finds_by_invoice_id
    results = repository.find_by_invoice_id("539")
    assert_equal "2402", results.id
  end

  def test_it_finds_by_quantity
    results = repository.find_by_quantity("5")
    assert_equal "1", results.id
  end

  def test_it_finds_by_created_at
    results = repository.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal "1", results.invoice_id
  end

  def test_it_finds_by_updated_at
    results = repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal "1", results.invoice_id
  end

  def test_it_finds_all_by_invoice_id
    results = repository.find_all_by_invoice_id("539")
    assert_equal 3, results.size
  end

  def test_it_finds_all_by_quantity
    results = repository.find_all_by_quantity("5")
    assert_equal 2164, results.size
  end

end
