require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
	attr_reader :merchant_repository

	def setup
		@merchant_repository = MerchantRepository.new(SalesEngine.new)
	end

	def test_it_returns_all_instances_of_merchant
		assert_equal 100, merchant_repository.all.count
	end

	def test_it_returns_a_random_merchant
		result = merchant_repository.random
		assert_instance_of Merchant, result
	end

	def test_it_finds_by_name
		results = merchant_repository.find_by_name("Bechtelar LLC")
		assert_equal "bechtelar llc", results.name
	end

	def test_it_finds_by_id
		results = merchant_repository.find_by_id("66")
		assert_equal "66", results.id
	end

	def test_it_finds_all_by_name
	  result = merchant_repository.find_all_by_name("Williamson group")
	  assert_equal 2, result.count
	end

	def test_it_can_get_top_x_merchants_by_revenue
		assert_equal "bob", merchant_repository.most_revenue(3).first.name
	end
end
