require 'csv'
require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
	attr_reader :invoice

	def setup
		@engine = SalesEngine.new
		invoice_attributes = [{id: "1", customer_id: 1, merchant_id: 26,status: "shipped", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2012-03-25 09:54:09 UTC"}] 
		@invoices = InvoiceRepository.new(@engine, invoice_attributes)
		@invoice = @invoices.all.first	
	end

	def test_it_returns_id
		assert_equal 1, invoice.id
	end

	def test_it_returns_a_customer_id
		assert_equal 1, invoice.customer_id
	end

	def test_it_returns_merchant_id
		assert_equal 26, invoice.merchant_id
	end

	def test_it_returns_status
		assert_equal "shipped", invoice.status
	end

	def test_it_returns_created_at
		assert_equal "2012-03-25 09:54:09 UTC", invoice.created_at
	end

	def test_it_returns_updated_at
		assert_equal "2012-03-25 09:54:09 UTC", invoice.updated_at
	end	
end
