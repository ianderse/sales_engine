require 'bigdecimal'
require 'date'
require_relative 'date_handler'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repo

  def initialize(params, repo)
    @id          = params[:id].to_i
    @name        = params[:name]
    @description = params[:description]
    @unit_price  = BigDecimal.new((params[:unit_price].to_f/100.00).to_s)
    @merchant_id = params[:merchant_id].to_i
    @created_at  = params[:created_at]
    @updated_at  = params[:updated_at]
    @repo = repo
  end

  #validate data

  def invoice_items
    repo.find_invoice_items_by_item_id(self.id)
  end

  def merchant
    repo.find_merchant_by_merchant_id(self.merchant_id)
  end

  def best_day

    invoices = invoice_items.select {|invoice_item| invoice_item.invoice}

    best_invoice_item = invoices.max_by do |invoice_item|
      invoices.each do |invoice_item2|
        if invoice_item.id == invoice_item2.id
          invoice_item.item_revenue + invoice_item2.item_revenue
        else
          invoice_item.item_revenue
        end
      end
    end

    best_invoice = best_invoice_item.invoice
    date = DateHandler.new(best_invoice.created_at)
    Date.new(date.year.to_i,date.month.to_i,date.day.to_i)
  end
end
