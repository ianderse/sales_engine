require 'bigdecimal'
require_relative 'date_handler'

class InvoiceItem
  attr_reader :id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :item_id,
              :invoice_id,
              :repo

  def initialize(params, repo)
    @id          = params[:id].to_i
    @quantity    = params[:quantity].to_i
    @unit_price  = BigDecimal.new((params[:unit_price].to_f/100.00).to_s)
    #to_date
    @created_at  = DateHandler.new(params[:created_at]).to_date
    @updated_at  = DateHandler.new(params[:updated_at]).to_date
    @item_id     = params[:item_id].to_i
    @invoice_id  = params[:invoice_id].to_i
    @repo = repo
  end

  def invoice
    repo.find_invoice_by_invoice_id(self.invoice_id)
  end

  def item
    repo.find_item_by_item_id(self.item_id)
  end

  def item_revenue
    BigDecimal.new(self.quantity * self.unit_price).truncate(2)
  end

  #This is potentially totally useless, keeping it just in case:
  def total_sold
    sold_items = []

    item.invoice_items.each do |invoice_item|
      sold_items << invoice_item.item
    end

    sold_items.group_by {|item| item.name}.values.max_by(&:size)
  end
end
