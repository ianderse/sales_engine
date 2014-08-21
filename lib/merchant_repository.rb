require 'csv'
require_relative "merchant"
require_relative "../lib/csv_handler"

class MerchantRepository
	attr_reader :merchants, :engine
	#pass engine itself instead of self

  def initialize(engine)
    csv      = CsvHandler.new("./data/merchants.csv")
    @merchants = csv.data.collect {|row| Merchant.new(row, self)}
		@engine = engine
  end

  def all
  	merchants
  end

  def random
  	merchants.sample
  end

  def find_by_id(id)
    merchants.detect {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    merchants.detect {|merchant| merchant.name == name.downcase}
  end

  def find_by_created_at(created_at)
    merchants.detect {|merchant| merchant.created_at == created_at}
  end

  def find_all_by_name(name)
    merchants.select {|merchant| merchant.name == name.downcase}
  end

  def find_all_by_created_at(created_at)
    merchants.select {|merchant| merchant.created_at == created_at}
  end

  def find_items_by_merchant_id(id)
    engine.find_items_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    engine.find_invoices_by_merchant_id(id)
  end

  def find_invoices_by_date(date)

  end

end
