require 'csv'
require_relative "merchant"
require_relative "../lib/csv_handler"

class MerchantRepository
	attr_reader :merchants, :engine

  def initialize(engine, merchants_attributes)
    @engine = engine
    @merchants = merchants_attributes.collect {|params| Merchant.new(params, self)}
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

  def most_revenue(num)
    all.sort {|merchant| merchant.revenue.to_i}.reverse.take(num)
  end

  def most_items(num)

  end
end
