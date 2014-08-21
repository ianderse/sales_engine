require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
	attr_reader :merchant

	def setup
		row  = {:id => 1, :name => "schroeder-Jerde", :created_at => "2012-03-27 14:53:59 UTC", :updated_at => "2012-03-27 14:53:59 UTC"}
		repo = Minitest::Mock.new
		@merchant = Merchant.new(row, repo)
	end

	def test_returns_name_of_merchant
	  assert_equal "schroeder-jerde", merchant.name
	end

	def test_returns_id_of_mercahnt
		assert_equal 1, merchant.id
	end

	def test_returns_when_merchant_was_created
		assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
	end

	def test_returns_when_merchant_was_updated
		assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
	end

  def test_it_normalizes_its_id_to_an_integer
    assert_equal 1, Merchant.new({id:   1}, nil).id
    assert_equal 1, Merchant.new({id: "1"}, nil).id
  end

  def test_it_normalizes_created_at_and_updated_at_to_a_date
    skip
  end
end
