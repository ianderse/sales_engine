require 'csv'
require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/csv_handler'
require_relative '../lib/sales_engine'

class TransactionTest < Minitest::Test
  attr_reader :transaction

  def setup
    @engine = SalesEngine.new
    transaction_attributes = [{id: "1", invoice_id: "5", result: "success", credit_card_number: "4654405418249632", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}]
    @transactions = TransactionRepository.new(@engine, transaction_attributes)
    @transaction = @transactions.all.first
  end

  def test_it_returns_an_id
    assert_equal 1, transaction.id
  end

  def test_it_returns_an_invoice_id
     assert_equal 5, transaction.invoice_id
  end

  def test_it_returns_a_credit_card_number
    assert_equal "4654405418249632", transaction.cc_number
  end

  def test_it_returns_a_credit_card_expiration_date
    assert_equal nil, transaction.cc_expiration
  end

  def test_it_returns_a_created_at_date
    assert_equal DateHandler.new("2012-03-27 14:54:09 UTC").to_date, transaction.created_at
  end

  def test_it_returns_an_updated_at_date
    assert_equal DateHandler.new("2012-03-27 14:54:09 UTC").to_date, transaction.updated_at
  end

end
