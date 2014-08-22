require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
	attr_reader :merchant

	def setup
		merchant_attributes = [{:id => "1", :name => "schroeder-Jerde", :created_at => "2012-03-27 14:53:59 UTC", :updated_at => "2012-03-27 14:53:59 UTC"}]
		@engine = SalesEngine.new
		@merchants = MerchantRepository.new(@engine, merchant_attributes)
		@merchant = @merchants.all.first
	end

	def test_returns_name_of_merchant
	  assert_equal "schroeder-Jerde", merchant.name
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

end
