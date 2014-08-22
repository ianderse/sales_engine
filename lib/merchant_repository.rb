require 'csv'
require_relative "merchant"
require_relative "../lib/csv_handler"

class MerchantRepository
  attr_reader :merchants, :engine

  def initialize(engine, merchant_details)
    @engine = engine
    @merchants = merchant_details.collect {|params| Merchant.new(params, self)}
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
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
    merchants.detect {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_by_created_at(created_at)
    merchants.detect {|merchant| merchant.created_at == created_at}
  end

  def find_all_by_name(name)
    merchants.select {|merchant| merchant.name.downcase == name.downcase}
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
    all.sort {|merchant| merchant.items_sold}.reverse.take(num)
  end

  def revenue(date)
    total = BigDecimal.new("0")
    all.each do |merchant|
      total += merchant.revenue(date)
    end
    total
  end
end
