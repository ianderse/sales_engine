require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class AssociationsTest < Minitest::Test
	attr_reader :merchant

  def set_world(attributes)
    @engine                     = SalesEngine.new
    @merchant_repo              = MerchantRepository.new(@engine, attributes.fetch(:merchants_attributes, []))
    @item_repo                  = ItemRepository.new(@engine, attributes.fetch(:items_attributes, []))
    @engine.merchant_repository = @merchant_repo
    @engine.item_repository     = @item_repo
  end

	def test_it_knows_what_items_are_associated_with_it
    set_world merchants_attributes: [{id: 12}],
              items_attributes:     [{name: 'A', merchant_id: 12},
                                     {name: 'B', merchant_id: 13},
                                     {name: 'C', merchant_id: 12},
                                    ]

    merchant = @merchant_repo.all.first
    assert_equal ['A', 'C'], merchant.items.map { |item| item.name }
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
		assert_equal "Albina", merchant.favorite_customer.first_name
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

	#these are all broken:
	def test_it_returns_all_associated_invoices
    assert_equal 8, customer.invoices.size
  end

  def test_it_returns_an_array_of_a_customers_tranactions
    assert_equal 8, customer.transactions.count
  end

  def test_favorite_merchant_returns_merchant_with_most_successful_tranactions
    skip
    assert_equal 11, customer.favorite_merchant
  end

  def test_it_can_find_related_invoice_items
		assert_equal 24, item.invoice_items.size
	end

	def test_it_can_find_related_merchants
		assert_equal "schroeder-jerde", item.merchant.name
	end

	def test_it_returns_an_items_best_day
		assert_equal "2012-03-27", item.best_day
	end

	def test_it_can_get_top_x_merchants_by_revenue
		assert_equal "bob", merchant_repository.most_revenue(3).first.name
	end

	def test_it_knows_its_own_items
    assert_equal 12,  invoice_item.first.item.merchant_id
  end

  def test_it_knows_associated_transactions
		assert_equal 1, invoice.transactions.size
	end

	def test_it_knows_associated_invoice_items
		assert_equal 8, invoice.invoice_items.size
	end

	def test_it_knows_all_items_by_way_of_invoice_item
		assert_equal 8, invoice.items.size
	end

	def test_it_knows_associated_customer_with_self
		assert_equal "Joey", invoice.customer.first_name
	end

	def test_it_knows_associated_merchant_with_self
		assert_equal "balistreri, schaefer and kshlerin", invoice.merchant.name
	end
end
