require 'csv'
require_relative 'test_helper'
require_relative '../lib/invoice_item'
require_relative '../lib/csv_handler'
require_relative '../lib/sales_engine'

class InvoiceItemTest < Minitest::Test
  attr_reader :invoice_item

  def setup
    @engine = SalesEngine.new
    invoice_item_attributes = [{id: "1", quantity: "5", unit_price: "5545", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC", item_id: "5", invoice_id: "12"}]
    @invoice_items = InvoiceItemRepository.new(@engine, invoice_item_attributes)
    @invoice_item = @invoice_items.all.first
  end

  def test_it_returns_an_id
    assert_equal 1, invoice_item.id
  end

  def test_it_returns_a_big_decimal_object
    assert_instance_of BigDecimal, invoice_item.unit_price
  end

  def test_it_returns_created_at
    assert_equal DateHandler.new("2012-03-27 14:54:09 UTC").to_date, invoice_item.created_at
  end

  def test_it_returns_updated_at
   assert_equal DateHandler.new("2012-03-27 14:54:09 UTC").to_date, invoice_item.created_at
  end

  def test_it_returns_item_id
    assert_equal 5, invoice_item.item_id
  end

  def test_it_returns_invoice_id
    assert_equal 12, invoice_item.invoice_id
  end

end
