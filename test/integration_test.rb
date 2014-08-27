require 'date'
require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class IntegrationTest < Minitest::Test

	def setup
		@engine = SalesEngine.new
		@engine.startup
	end

	def test_invoice_knows_if_it_is_pending
		invoice = @engine.invoice_repository.find_by_id(13)
		pending_invoices = @engine.invoice_repository.pending

		assert pending_invoices.include?(invoice)
	end

	def test_customer_knows_its_pending_invoices
		assert_equal [], @engine.customer_repository.find_by_id(2).pending_invoices
	end

	def test_customer_knows_days_since_last_activity
		date = Date.parse("March 29, 2012")
		date2 = Date.parse("March 29, 2012")

		days_since = @engine.customer_repository.find_by_id(1).days_since_activity
		assert (days_since >= 3 || days_since <= 4)
	end

	def test_customer_can_find_most_items
		assert_equal 622, @engine.customer_repository.most_items.id
	end

	def test_customer_can_find_most_revenue
		assert_equal 601, @engine.customer_repository.most_revenue.id
	end

	def test_it_can_find_revenue_for_specific_date
		merchant = @engine.merchant_repository.find_by_name "Willms and Sons"
		date = Date.parse "Fri, 09 Mar 2012"
		assert_equal BigDecimal.new("8373.29"), merchant.revenue(date)
	end

	def test_it_can_find_revenue_for_specific_date_merchant_repo
		date = Date.parse "Tue, 20 Mar 2012"
		assert_equal BigDecimal.new("2549722.91"), @engine.merchant_repository.revenue(date)
	end

	def test_it_can_find_best_day_for_specific_item
		item = @engine.item_repository.find_by_name("Item Accusamus Ut")
		assert_equal Time.new(2012,03,24).to_date, item.best_day.to_date
	end

	def test_it_can_find_pending_invoices_for_specific_merchants
		merchant = @engine.merchant_repository.find_by_name("Parisian Group")
		customers = merchant.customers_with_pending_invoices

		customers.each do |customer|
			customer.last_name
		end
		assert_equal 4, customers.count

	end

	def test_it_can_find_favorite_customer_for_specific_merchant
		merchant = @engine.merchant_repository.find_by_name("Terry-Moore")
		assert_equal "Abernathy", merchant.favorite_customer.last_name
	end

	def test_it_can_find_item_with_most_revenue
		assert_equal "Item Dicta Autem", @engine.item_repository.most_revenue(5).first.name
		assert_equal "Item Amet Accusamus", @engine.item_repository.most_revenue(5).last.name
	end

	def test_it_can_find_item_with_most_sold
		assert_equal "Item Nam Magnam", @engine.item_repository.most_items(37)[1].name
	end

end
