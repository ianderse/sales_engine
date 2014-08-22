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

end
