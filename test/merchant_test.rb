require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
	attr_reader :merchant

	def setup
		row = {:id => "1", :name => "schroeder-Jerde", :created_at => "2012-03-27 14:53:59 UTC", :updated_at => "2012-03-27 14:53:59 UTC"}
		@engine = SalesEngine.new
		@engine.startup
		@merchant = Merchant.new(row, @engine.merchant_repository)
	end

	def test_it_exists
		assert Merchant
	end

	def test_returns_name_of_merchant
	  assert_equal "schroeder-jerde", merchant.name
	end

	def test_returns_id_of_mercahnt
		assert_equal "1", merchant.id
	end

	def test_returns_when_merchant_was_created
		assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
	end

	def test_returns_when_merchant_was_updated
		assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
	end

	def test_it_knows_what_items_are_associated_with_it
		assert_equal 15, merchant.items.size
	end

	def test_it_knows_what_invoices_are_associated_with_it
		assert_equal 59, merchant.invoices.size
	end

	def test_it_can_get_revenue_for_a_specific_date
		assert_equal "17694", merchant.revenue("2012-03-27")
	end

	def test_it_can_get_total_revenue
		assert_equal "528187", merchant.revenue
	end

	def test_it_can_return_customers_with_pending_invoices
		assert_equal 19, merchant.customers_with_pending_invoices.size
	end

		def test_it_can_return_its_favorite_customer
		assert_equal "Parker", merchant.favorite_customer.first_name
	end

	def test_it_can_get_total_revenue_with_stubs
		invoice = Minitest::Mock.new
		invoice_item = Minitest::Mock.new
		invoice_item_2 = Minitest::Mock.new
		transaction = Minitest::Mock.new
		invoice.expect :transactions, [ transaction ]
		transaction.expect :result, "success"
		transaction.expect :successful_transaction?, true
		invoice.expect :invoice_items, [ invoice_item, invoice_item_2 ]
		invoice_item.expect :item_revenue, "5"
		invoice_item_2.expect :item_revenue, "30"

		merchant.stub :invoices, [ invoice ] do
			assert_equal "35", merchant.revenue
		end
	end

end
