require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :repository

	def setup
		@engine = SalesEngine.new
		invoice_attributes = [{id: 1,customer_id: 1, merchant_id: 26, status: "shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2012-03-25 09:54:09 UTC"}]
    @repository = InvoiceRepository.new(@engine, invoice_attributes)
	end

	def test_it_can_return_all
	  assert_equal 1, repository.all.count
	end

	def test_it_can_return_a_random_instance
	  assert_instance_of Invoice, repository.random
	end

	def test_it_finds_by_id
		results = repository.find_by_id(1)
		assert_equal 26, results.merchant_id
	end

	def test_it_finds_by_customer_id
		results = repository.find_by_customer_id(1)
		assert_equal 1, results.id
	end

	def test_it_finds_by_merchant_id
		results = repository.find_by_merchant_id(26)
		assert_equal 1, results.customer_id
	end

	def test_it_finds_by_status
		results = repository.find_by_status("shipped")
		assert_equal 26, results.merchant_id
	end

	def test_it_finds_by_created_at
		results = repository.find_by_created_at("2012-03-25 09:54:09 UTC")
		assert_equal 26, results.merchant_id
	end

	def test_it_finds_all_by_customer_id
	  results = repository.find_all_by_customer_id(1)
	  assert_equal 1, results.count
	end

	def test_it_finds_all_by_merchant_id
		results = repository.find_all_by_merchant_id(26)
		assert_equal 1, results.count
	end

	def test_it_finds_all_by_status
		results = repository.find_all_by_status("shipped")
		assert_equal 1, results.count
	end
end
