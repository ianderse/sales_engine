require 'csv'
require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/csv_handler'
require_relative '../lib/sales_engine'

class ItemTest < Minitest::Test
	attr_reader :sample

  def setup
		@engine = SalesEngine.new
		@engine.startup
	  csv = CsvHandler.new("./data/items.csv")
	  @sample = csv.data.collect {|row| Item.new(row, @engine.item_repository)}
	end

	def test_it_returns_a_name
		assert_equal "Item Qui Esse", sample.first.name
	end

	def test_it_returns_an_id
		assert_equal "1", sample.first.id
	end

	def test_it_returns_a_big_decimal_object
		assert_instance_of BigDecimal, sample.first.unit_price
	end

	def test_it_returns_a_mercahnt_id
		assert_equal "1", sample.first.merchant_id
	end

	def test_it_returns_created_at
		assert_equal "2012-03-27 14:53:59 UTC", sample.first.created_at
	end

	def test_it_can_find_related_invoice_items
		assert_equal 24, sample.first.invoice_items.size
	end

	def test_it_can_find_related_merchants
		assert_equal "schroeder-jerde", sample.first.merchant.name
	end

	def test_it_returns_an_items_best_day
		assert_equal "2012-03-27", sample.first.best_day
	end

end
