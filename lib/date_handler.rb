#should this be a module?
require 'date'
class DateHandler
  attr_reader :year, :month, :day, :time, :date

  def initialize(date)
    split_date = date.split(' ')
    @year = split_date[0][0..3].to_i
    @month = split_date[0][5..6].to_i
    @day = split_date[0][8..9].to_i
    @time = split_date[1]
    @date = split_date[0]
  end

  def to_date
    Date.new(year,month,day)
  end

end
