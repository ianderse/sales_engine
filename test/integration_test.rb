require 'date'
require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class IntegrationTest < Minitest::Test

	def setup

	end

	def test_it_can_find_best_day_for_specific_item
		@engine = SalesEngine.new
		@engine.startup

		item = @engine.item_repository.find_by_name("Item Accusamus Ut")

		#assert_equal "2012-03-27", item.best_day.to_date
		item.best_day

	end

	def test_it_can_find_pending_invoices_for_specific_merchants
		@engine = SalesEngine.new
		@engine.startup
		merchant = @engine.merchant_repository.find_by_name("Parisian Group")
		customers = merchant.customers_with_pending_invoices

		customers.each do |customer|
			customer.last_name
		end
		assert_equal 4, customers.count

	end

	def test_it_can_find_favorite_customer_for_specific_merchant
		@engine = SalesEngine.new
		@engine.startup
		merchant = @engine.merchant_repository.find_by_name("Terry-Moore")

		assert_equal "Abernathy", merchant.favorite_customer.last_name
	end

end
