require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
	attr_reader :items

	def setup
		@engine = SalesEngine.new
		item_attrubutes = [{id: 1, name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", unit_price: 75107, merchant_id: 1, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC"}]
		@items = ItemRepository.new(@engine, item_attrubutes)
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
		assert_equal "Item Qui Esse", results.name
	end

	def test_you_can_find_by_name
		results = items.find_by_name("Item Qui Esse")
		assert_equal 1, results.id
	end

	def test_you_can_find_by_description
		description = "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro."
		results = items.find_by_description(description)
		assert_equal 1, results.id
	end

	def test_you_can_find_by_unit_price
		results = items.find_by_unit_price(BigDecimal.new("751.07"))
		assert_equal 1, results.id
	end

	def test_you_can_find_by_merchant_id
		results = items.find_by_merchant_id(1)
		assert_equal 1, results.id
	end
end
