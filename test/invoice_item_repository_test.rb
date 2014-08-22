require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_items

  def setup
    @engine = SalesEngine.new
    invoice_item_attributes = [{id: 1, item_id: 539, invoice_id: 1, quantity: 5, unit_price: 13635, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}]
    @invoice_items = InvoiceItemRepository.new(@engine, invoice_item_attributes)
  end

  def test_it_can_return_all
    assert_equal 1, invoice_items.all.count
  end

  def test_it_can_return_a_random_instance
    assert_instance_of InvoiceItem, invoice_items.random
  end

  def test_it_finds_by_id
    results = invoice_items.find_by_id(1)
    assert_equal 1, results.invoice_id
  end

  def test_it_finds_by_invoice_id
    results = invoice_items.find_by_invoice_id(1)
    assert_equal 1, results.id
  end

  def test_it_finds_by_quantity
    results = invoice_items.find_by_quantity(5)
    assert_equal 1, results.id
  end

  def test_it_finds_by_created_at
    results = invoice_items.find_by_created_at(DateHandler.new("2012-03-27 14:54:09 UTC").to_date)
    assert_equal 1, results.invoice_id
  end

  def test_it_finds_by_updated_at
    results = invoice_items.find_by_updated_at(DateHandler.new("2012-03-27 14:54:09 UTC").to_date)
    assert_equal 1, results.invoice_id
  end

  def test_it_finds_all_by_invoice_id
    results = invoice_items.find_all_by_invoice_id(1)
    assert_equal 1, results.size
  end

  def test_it_finds_all_by_quantity
    results = invoice_items.find_all_by_quantity(5)
    assert_equal 1, results.size
  end

end
