require 'date'
require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class IntegrationTest < Minitest::Test

	def setup
		skip
		@engine = SalesEngine.new
		@engine.startup
	end

	def test_it_can_find_revenue_for_specific_date
		skip
		merchant = @engine.merchant_repository.find_by_name "Willms and Sons"
		date = Date.parse "Fri, 09 Mar 2012"
		assert_equal BigDecimal.new("8373.29"), merchant.revenue(date)
	end

	def test_it_can_find_revenue_for_specific_date_merchant_repo
		skip
		date = Date.parse "Tue, 20 Mar 2012"
		assert_equal BigDecimal.new("2549722.91"), @engine.merchant_repository.revenue(date)
	end

	def test_it_can_find_best_day_for_specific_item
		skip
		item = @engine.item_repository.find_by_name("Item Accusamus Ut")
		assert_equal Time.new(2012,03,18).to_date, item.best_day.to_date
	end

	def test_it_can_find_pending_invoices_for_specific_merchants
		skip
		merchant = @engine.merchant_repository.find_by_name("Parisian Group")
		customers = merchant.customers_with_pending_invoices

		customers.each do |customer|
			customer.last_name
		end
		assert_equal 4, customers.count

	end

	def test_it_can_find_favorite_customer_for_specific_merchant
		skip
		merchant = @engine.merchant_repository.find_by_name("Terry-Moore")
		assert_equal "Abernathy", merchant.favorite_customer.last_name
	end

	def test_it_can_find_item_with_most_revenue
		skip
		assert_equal "Item Dicta Autem", @engine.item_repository.most_revenue(5).first.name
		assert_equal "Item Amet Accusamus", @engine.item_repository.most_revenue(5).last.name
	end

	def test_it_can_find_item_with_most_sold
		skip
		assert_equal "Item Nam Magnam", @engine.item_repository.most_items(37)[1].name
	end

end
