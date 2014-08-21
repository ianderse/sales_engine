require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :repository

	def setup
    @repository = InvoiceRepository.new(SalesEngine.new)
	end

	def test_it_can_return_all
	  assert_equal 4843, repository.all.count
	end

	def test_it_can_return_a_random_instance
	  assert_instance_of Invoice, repository.random
	end

	def test_it_finds_by_id
		results = repository.find_by_id("1")
		assert_equal "26", results.merchant_id
	end

	def test_it_finds_by_customer_id
		results = repository.find_by_customer_id("3")
		assert_equal "10", results.id
	end

	def test_it_finds_by_merchant_id
		results = repository.find_by_merchant_id("43")
		assert_equal "9", results.customer_id
	end

	def test_it_finds_by_status
		results = repository.find_by_status("shipped")
		assert_equal "26", results.merchant_id
	end

	def test_it_finds_by_created_at
		results = repository.find_by_created_at("2012-03-06 21:54:10 UTC")
		assert_equal "86", results.merchant_id
	end

	def test_it_finds_all_by_customer_id
	  results = repository.find_all_by_customer_id("10")
	  assert_equal 8, results.count
	end

	def test_it_finds_all_by_merchant_id
		results = repository.find_all_by_merchant_id("33")
		assert_equal 55, results.count
	end

	def test_it_finds_all_by_status
		results = repository.find_all_by_status("shipped")
		assert_equal 4843, results.count
	end
end
