require 'bigdecimal'

class InvoiceItem
  attr_reader :id, :quantity, :unit_price, :created_at, :updated_at, :item_id, :invoice_id, :repo

  def initialize(params, repo)
    @id          = params[:id].to_i
    @quantity    = params[:quantity].to_i
    @unit_price  = BigDecimal.new((params[:unit_price].to_f / 100).to_s)
    #to_date
    @created_at  = params[:created_at]
    @updated_at  = params[:updated_at]
    @item_id     = params[:item_id].to_i
    @invoice_id  = params[:invoice_id].to_i
    @repo = repo
  end

  def invoice
    repo.find_invoice_item_by_invoice_id(self.invoice_id)
  end

  def item
    repo.find_item_by_item_id(self.item_id)
  end

  def item_revenue
    BigDecimal.new(self.quantity.to_i * self.unit_price.to_i)
  end
end
