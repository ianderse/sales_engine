require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
	attr_reader :items

	def setup
		item_attributes = [{id: "1", name: "Item Name", description: "Item Description", unit_price: "5523", merchant_id: "1" }]
		@items = ItemRepository.new(SalesEngine.new, item_attributes)
	end

	def test_it_returns_all_items
		results = items.all
		assert_equal 1, items.all.count
	end

	def test_it_returns_a_random_element
		assert_instance_of Item, items.random
	end

	def test_you_can_find_by_id
		results = items.find_by_id(1)
		assert_equal "Item Name", results.name
	end

	def test_you_can_find_by_name
		results = items.find_by_name("Item Name")
		assert_equal 1, results.id
	end

	def test_you_can_find_by_description
		description = "Item Description"
		results = items.find_by_description(description)
		assert_equal 1, results.id
	end

	def test_you_can_find_by_unit_price
		results = items.find_by_unit_price(BigDecimal.new("5523"))
		assert_equal 1, results.id
	end

	def test_you_can_find_by_merchant_id
		results = items.find_by_merchant_id(1)
		assert_equal 1, results.id
	end
end
