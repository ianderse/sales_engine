require 'csv'
require_relative 'test_helper'
require_relative '../lib/invoice_item'
require_relative '../lib/csv_handler'
require_relative '../lib/sales_engine'

class InvoiceItemTest < Minitest::Test
  attr_reader :sample

  def setup
    @engine = SalesEngine.new
    @engine.startup

    csv = CsvHandler.new("./data/invoice_items.csv")
    @sample = csv.data.collect {|row| InvoiceItem.new(row, @engine.invoice_item_repository)}
  end

  def test_it_returns_an_id
    assert_equal "1", sample.first.id
  end

  def test_it_returns_a_big_decimal_object
    assert_instance_of BigDecimal, sample.first.unit_price
  end

  def test_it_returns_created_at
    assert_equal "2012-03-27 14:54:09 UTC", sample.first.created_at
  end

  def test_it_returns_updated_at
   assert_equal "2012-03-27 14:54:09 UTC", sample.first.created_at
  end

  def test_it_returns_item_id
    assert_equal "539", sample.first.item_id
  end

  def test_it_returns_invoice_id
    assert_equal "1", sample.first.invoice_id
  end

  def test_it_knows_its_own_items
    assert_equal "26",  sample.first.item.merchant_id
  end

end
