require 'bigdecimal'
require 'bigdecimal/util'
require 'csv'
require_relative '../lib/csv_handler'
require_relative '../lib/item'

class ItemRepository
  attr_reader :items, :engine

  def initialize(engine, items_attributes)
    @engine = engine
    @items = items_attributes.collect {|params| Item.new(params, self)}
  end

   def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    items
  end

  def random
    items.sample
  end

  def find_by_id(id)
    items.detect {|item| item.id == id}
  end

  def find_by_name(name)
    items.detect {|item| item.name == name}
  end

  def find_by_description(description)
    items.detect {|item| item.description == description}
  end

  def find_by_unit_price(unit_price)
    items.detect {|item| item.unit_price == unit_price}
  end

  def find_by_merchant_id(merchant_id)
    items.detect {|item| item.merchant_id == merchant_id}
  end

  def find_all_by_name(name)
    items.select {|item| item.name == name}
  end

  def find_all_by_description(description)
    items.select {|item| item.description == description}
  end

  def find_all_by_unit_price(unit_price)
    items.select {|item| item.unit_price == unit_price}
  end

  def find_all_by_merchant_id(merchant_id)
    items.select {|item| item.merchant_id == merchant_id}
  end

  def find_all_by_created_at(created_at)
    items.select {|item| item.created_at == created_at}
  end

  def find_invoice_items_by_item_id(id)
    engine.find_invoice_items_by_item_id(id)
  end

  def find_merchant_by_merchant_id(id)
    engine.find_merchant_by_merchant_id(id)
  end

  def most_revenue(num)
    all.each do |item|
      item.invoice_items.sort {|invoice_item| invoice_item.item_revenue.to_i}.take(num).map do |invoice_item|
        invoice_item.item
      end
    end
  end

  def most_items(num)
    all.each do |item|
      item.invoice_items.group_by {|invoice_item| invoice_item.item.name}.values.take(num)#.max_by(&:size)#.take(num)
    end
  end
end
