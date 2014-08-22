require 'csv'
require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/csv_handler'
require_relative '../lib/sales_engine'

class ItemTest < Minitest::Test
	attr_reader :item

  def setup
		@engine = SalesEngine.new
		item_attributes = [{id: "1", name: "Item Name", description: "Item Description", unit_price: "5523", merchant_id: "1", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC" }]
    @items = ItemRepository.new(@engine, item_attributes)
    @item = @items.all.first
	end

	def test_it_returns_a_name
		assert_equal "Item Name", item.name
	end

	def test_it_returns_an_id
		assert_equal 1, item.id
	end

	def test_it_returns_a_big_decimal_object
		assert_instance_of BigDecimal, item.unit_price
	end

	def test_it_returns_a_mercahnt_id
		assert_equal 1, item.merchant_id
	end

	def test_it_returns_created_at
		assert_equal DateHandler.new("2012-03-27 14:54:09 UTC").to_date, item.created_at
	end

end
