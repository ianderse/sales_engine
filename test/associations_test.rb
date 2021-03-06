require 'date'
require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class AssociationsTest < Minitest::Test
	attr_reader :merchant, :customer, :item, :invoice_item, :invoice

  def setup
  	merchants_attributes = [{name: 'Merchant Number 1', id: "12", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"},
  													{name: 'Merchant Number 2', id: "5", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}]

    items_attributes =     [{id: "5", name: 'A', description: "item description", unit_price: "5545", merchant_id: 12, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"},
                           {id: "10", name: 'B', description: "item description", unit_price: "1234", merchant_id: 13, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"},
                           {id: "2", name: 'C', description: "item description", unit_price: "1000", merchant_id: 12, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}]

    invoice_attributes = [{id: "5", customer_id: "1", merchant_id: "12" ,status: "shipped", created_at: "2012-03-27 09:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"},
    											{id: "2", customer_id: "1", merchant_id: "5" ,status: "shipped", created_at: "2012-03-27 09:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}]

    customer_attributes = [{id: "1", first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}]

    transaction_attributes = [{id: "1", invoice_id: "5", result: "success", credit_card_number: "4654405418249632", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"},
    													{id: "2", invoice_id: "5", result: "failed", credit_card_number: "4654405418239632", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-28 14:54:09 UTC"},
    													{id: "2", invoice_id: "2", result: "success", credit_card_number: "4654405428239632", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-28 14:54:09 UTC"}]

    invoice_item_attributes = [{id: "1", quantity: "5", unit_price: "5000", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC", item_id: "5", invoice_id: "5"},
    													 {id: "2", quantity: "5", unit_price: "1000", created_at: "2012-03-26 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC", item_id: "2", invoice_id: "2"}]

    @engine                     = SalesEngine.new
    @merchant_repo              = MerchantRepository.new(@engine, merchants_attributes)
    @item_repo                  = ItemRepository.new(@engine, items_attributes)
    @invoice_repo								= InvoiceRepository.new(@engine, invoice_attributes)
    @invoice_items_repo					= InvoiceItemRepository.new(@engine, invoice_item_attributes)
    @customer_repo							= CustomerRepository.new(@engine, customer_attributes)
    @transaction_repo 					= TransactionRepository.new(@engine, transaction_attributes)

    @engine.merchant_repository = @merchant_repo
    @engine.item_repository     = @item_repo
    @engine.invoice_repository  = @invoice_repo
    @engine.invoice_item_repository = @invoice_items_repo
    @engine.customer_repository = @customer_repo
    @engine.transaction_repository = @transaction_repo

    @merchant = @merchant_repo.all.first
    @customer = @customer_repo.all.first
    @item     = @item_repo.all.first
    @invoice_item = @invoice_items_repo.all.first
    @invoice  = @invoice_repo.all.first
  end

	def test_it_knows_what_items_are_associated_with_it

    assert_equal ['A', 'C'], merchant.items.map { |item| item.name }
	end

	def test_it_knows_what_invoices_are_associated_with_it
		assert_equal 1, merchant.invoices.size
	end

	def test_it_can_get_revenue_for_a_specific_date
		assert_equal BigDecimal.new("250.00"), merchant.revenue(DateHandler.new("2012-03-27").to_date)
	end

	def test_it_can_get_total_revenue
		assert_equal BigDecimal.new("250.00"), merchant.revenue
	end

	def test_it_can_return_customers_with_pending_invoices
		assert_equal 0, merchant.customers_with_pending_invoices.size
	end

	def test_it_can_return_its_favorite_customer
		assert_equal "Joey", merchant.favorite_customer.first_name
	end

	# def test_it_can_get_total_revenue_with_stubs
	#   leaving in for learning purposes
	# 	skip
	# 	invoice = Minitest::Mock.new
	# 	invoice_item = Minitest::Mock.new
	# 	invoice_item_2 = Minitest::Mock.new
	# 	transaction = Minitest::Mock.new
	# 	invoice.expect :transactions, [ transaction ]
	# 	transaction.expect :result, "success"
	# 	transaction.expect :successful_transaction?, true
	# 	invoice.expect :invoice_items, [ invoice_item, invoice_item_2 ]
	# 	invoice_item.expect :item_revenue, "5"
	# 	invoice_item_2.expect :item_revenue, "30"

	# 	merchant.stub :invoices, [ invoice ] do
	# 		assert_equal 35, merchant.revenue
	# 	end
	# end

	def test_it_returns_all_associated_invoices
    assert_equal 2, customer.invoices.size
  end

  def test_it_returns_an_array_of_a_customers_tranactions
    assert_equal 2, customer.transactions.count
  end

  def test_favorite_merchant_returns_merchant_with_most_successful_tranactions
    assert_equal "Merchant Number 1", customer.favorite_merchant.name
  end

  def test_it_can_find_related_invoice_items
		assert_equal 1, item.invoice_items.size
	end

	def test_it_can_find_related_merchants
		assert_equal "Merchant Number 1", item.merchant.name
	end

	def test_it_returns_an_items_best_day
		assert_equal Date.new(2012,03,27), item.best_day
	end

	def test_it_can_get_top_x_merchants_by_revenue
		assert_equal "Merchant Number 1", @merchant_repo.most_revenue(3).first.name
	end

	def test_it_knows_its_own_items
    assert_equal 12,  invoice_item.item.merchant_id
  end

  def test_it_knows_associated_transactions
		assert_equal 2, invoice.transactions.size
	end

	def test_it_knows_associated_invoice_items
		assert_equal 1, invoice.invoice_items.size
	end

	def test_it_knows_all_items_by_way_of_invoice_item
		assert_equal 1, invoice.items.size
	end

	def test_it_knows_associated_customer_with_self
		assert_equal "Joey", invoice.customer.first_name
	end

	def test_it_knows_associated_merchant_with_self
		assert_equal "Merchant Number 1", invoice.merchant.name
	end

	def test_merchant_can_return_all_items_sold
		assert_equal 1, merchant.items_sold
	end

	def test_merchant_repo_can_get_revenue_on_a_date
		assert_equal BigDecimal.new("300.00"), @merchant_repo.revenue(DateHandler.new("2012-03-27").to_date)
	end

	def test_item_repo_can_get_total_item_revenue
		assert_equal "A", @item_repo.most_revenue(2).first.name
	end

	def test_item_repo_can_get_most_sold_items
		assert_equal "C", @item_repo.most_items(2).first.name
	end

	def test_invoice_repo_can_create_a_new_invoice
		invoice = @invoice_repo.create(customer: @customer_repo.all.first, merchant: @merchant_repo.all.first, status: "shipped",
                         items: [@item_repo.all.first, @item_repo.all[1], @item_repo.all.last])

		assert_equal 3, invoice.id
	end

	def test_invoice_repo_can_add_a_credit_card
		invoice = @invoice_repo.create(customer: @customer_repo.all.first, merchant: @merchant_repo.all.first, status: "shipped",
                         items: [@item_repo.all.first, @item_repo.all[1], @item_repo.all.last])
		invoice.charge(credit_card_number: "4444333322221111",
               credit_card_expiration: "10/13", result: "success")

		assert_equal "4444333322221111", invoice.transactions.last.cc_number
	end

	def test_customer_can_return_its_favorite_merchant
		assert @customer.favorite_merchant.is_a?(Merchant)
	end

end
