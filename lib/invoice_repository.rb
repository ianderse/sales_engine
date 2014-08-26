require 'csv'
require_relative 'invoice'
require_relative 'invoice_item'
require_relative '../lib/csv_handler'

class InvoiceRepository
  attr_reader :invoices, :engine

  def initialize(engine, invoices_attributes)
    @engine = engine
    @invoices = invoices_attributes.collect {|params| Invoice.new(params, self)}
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    invoices
  end

  def random
    invoices.sample
  end

  def find_by_id(id)
    invoices.detect {|invoice| invoice.id == id}
  end

  def find_by_customer_id(customer_id)
    invoices.detect {|invoice| invoice.customer_id == customer_id}
  end

  def find_by_merchant_id(merchant_id)
    invoices.detect {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_by_status(status)
    invoices.detect {|invoice| invoice.status == status}
  end

  def find_by_created_at(created_at)
    invoices.detect {|invoice| invoice.created_at == created_at}
  end

  def find_all_by_id(id)
    invoices.select {|invoice| invoice.id == id}
  end

  def find_all_by_customer_id(customer_id)
    invoices.select {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.select {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    invoices.select {|invoice| invoice.status == status}
  end

  def find_all_by_created_at(created_at)
    invoices.select {|invoice| invoice.created_at == created_at}
  end

  def find_transactions_by_invoice_id(id)
    engine.find_transactions_by_invoice_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    engine.find_invoice_items_by_invoice_id(id)
  end

  def find_customer_by_customer_id(id)
    engine.find_customer_by_customer_id(id)
  end

  def find_merchant_by_merchant_id(id)
    engine.find_merchant_by_merchant_id(id)
  end

  def create(params)
    #fuck this shit, refactor everything
    @customer = params.fetch(:customer)
    @merchant = params.fetch(:merchant)
    @status   = params.fetch(:status, "shipped")
    @items    = params.fetch(:items)
    @id       = @invoices.last.id + 1
    time      = Time.now
    created_at= "#{time.year}-#{time.month}-#{time.day}"

    grouped_items = @items.group_by {|item| item.id}
    first_key = grouped_items.keys.first
    first_items = grouped_items[first_key]
    grouped_items.size.times do |i|
      key = grouped_items.keys[i-1]
      items = grouped_items[key]
      #refactor below
      item_attr = {id: @engine.find_all_invoice_items.last.id+1,
                  quantity: items.size,
                  unit_price: items.first.unit_price,
                  created_at: created_at, updated_at: created_at,
                  item_id: items.first.id, invoice_id: @id}

      @engine.find_all_invoice_items <<
      InvoiceItem.new(item_attr, @engine.invoice_item_repository)
    end

    new_params = {id: @id, customer_id: @customer.id,
                  merchant_id: @merchant.id, status: @status,
                  created_at: created_at, updated_at: created_at}

    @invoices << Invoice.new(new_params, self)
    @invoices.last
  end

end
