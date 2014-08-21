require_relative 'test_helper'
require_relative '../lib/date_handler'

class DateHandlerTest < Minitest::Test
	attr_reader :date, :fixed_date

	def setup
		@date = "2012-03-27 14:53:59 UTC"
		@fixed_date = DateHandler.new(date)
	end

	def test_it_can_return_year
		assert_equal "2012", fixed_date.year
	end

	def test_it_can_return_month
		assert_equal "03", fixed_date.month
	end

	def test_it_can_return_day
		assert_equal "27", fixed_date.day
	end

	def test_it_can_return_time
		assert_equal "14:53:59", fixed_date.time
	end

	def test_it_can_return_full_date
		assert_equal "2012-03-27", fixed_date.date
	end
end
