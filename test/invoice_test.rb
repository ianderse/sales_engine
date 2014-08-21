require 'csv'
require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
	attr_reader :invoices

	def setup
		@engine = SalesEngine.new
		@engine.startup

		csv = CSV.open("./data/invoices.csv", headers:  true, header_converters: :symbol)
    @invoices = csv.collect {|row| Invoice.new(row, @engine.invoice_repository)}
	end

	def test_it_returns_id
		assert_equal "1", invoices.first.id
	end

	def test_it_returns_a_customer_id
		assert_equal "1", invoices.first.customer_id
	end

	def test_it_returns_merchant_id
		assert_equal "26", invoices.first.merchant_id
	end

	def test_it_returns_status
		assert_equal "shipped", invoices.first.status
	end

	def test_it_returns_created_at
		assert_equal "2012-03-25 09:54:09 UTC", invoices.first.created_at
	end

	def test_it_returns_updated_at
		assert_equal "2012-03-25 09:54:09 UTC", invoices.first.updated_at
	end

	def test_it_knows_associated_transactions
		assert_equal 1, invoices.first.transactions.size
	end

	def test_it_knows_associated_invoice_items
		assert_equal 8, invoices.first.invoice_items.size
	end

	def test_it_knows_all_items_by_way_of_invoice_item
		assert_equal 8, invoices.first.items.size
	end

	def test_it_knows_associated_customer_with_self
		assert_equal "Joey", invoices.first.customer.first_name
	end

	def test_it_knows_associated_merchant_with_self
		assert_equal "balistreri, schaefer and kshlerin", invoices.first.merchant.name
	end
end
