require 'csv'
require_relative 'invoice_item'
require_relative '../lib/csv_handler'

#should we have find by merchant id for this?

class InvoiceItemRepository
  attr_reader :invoice_items, :engine

  def initialize(engine, invoice_items_attributes)
    @engine = engine
    @invoice_items = invoice_items_attributes.collect {|params| InvoiceItem.new(params, self)}
  end

  def all
    invoice_items
  end

  def random
    invoice_items.sample
  end

  def find_by_id(id)
    invoice_items.detect {|invoice_item| invoice_item.id == id}
  end

  def find_by_invoice_id(id)
    invoice_items.detect {|invoice_item| invoice_item.invoice_id == id}
  end

  def find_by_item_id(id)
    invoice_items.detect {|invoice_item| invoice_item.item_id == id}
  end

  def find_by_quantity(quantity)
    invoice_items.detect {|invoice_item| invoice_item.quantity == quantity}
  end

  def find_by_created_at(created_at)
    invoice_items.detect {|invoice_item| invoice_item.created_at == created_at}
  end

  def find_by_updated_at(updated_at)
    invoice_items.detect {|invoice_item| invoice_item.updated_at == updated_at}
  end

  def find_all_by_id(id)
    invoice_items.select {|invoice_item| invoice_item.id == id}
  end

  def find_all_by_invoice_id(id)
    invoice_items.select {|invoice_item| invoice_item.invoice_id == id}
  end

  def find_all_by_item_id(id)
    invoice_items.select {|invoice_item| invoice_item.item_id == id}
  end

  def find_all_by_quantity(quantity)
    invoice_items.select {|invoice_item| invoice_item.quantity == quantity}
  end

  def find_all_by_created_at(created_at)
    invoice_items.select {|invoice_item| invoice_item.created_at == created_at}
  end

  def find_all_by_updated_at(updated_at)
    invoice_items.select {|invoice_item| invoice_item.updated_at == updated_at}
  end

  def find_invoice_item_by_invoice_id(id)
    engine.find_invoice_item_by_invoice_id(id)
  end

  def find_item_by_item_id(id)
    engine.find_item_by_item_id(id)
  end
end
