#should this be a module?
class DateHandler
	attr_reader :year, :month, :day, :time, :date

	def initialize(date)
		split_date = date.split(' ')
		@year = split_date[0][0..3]
		@month = split_date[0][5..6]
		@day = split_date[0][8..9]
		@time = split_date[1]
		@date = split_date[0]
	end

end
