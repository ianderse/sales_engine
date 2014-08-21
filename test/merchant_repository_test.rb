require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
	attr_reader :merchant_repository

	def setup
		merchant_attributes = [{id: "1", name: "Merchant Name"}]
		@merchant_repository = MerchantRepository.new(SalesEngine.new, merchant_attributes)
	end

	def test_it_returns_all_instances_of_merchant
		assert_equal 1, merchant_repository.all.count
	end

	def test_it_returns_a_random_merchant
		result = merchant_repository.random
		assert_instance_of Merchant, result
	end

	def test_it_finds_by_name
		results = merchant_repository.find_by_name("Merchant Name")
		assert_equal "merchant name", results.name
		assert_equal 1, results.id
	end

	def test_it_finds_by_id
		results = merchant_repository.find_by_id(1)
		assert_equal "merchant name", results.name
	end

	def test_it_finds_all_by_name
	  result = merchant_repository.find_all_by_name("Merchant Name")
	  assert_equal 1, result.count
	end

end
