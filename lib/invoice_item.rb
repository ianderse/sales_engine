require 'bigdecimal'

class InvoiceItem
  attr_reader :id, :quantity, :unit_price, :created_at, :updated_at, :item_id, :invoice_id, :repo

  def initialize(row, repo)
    @id          = row[:id]
    @quantity    = row[:quantity]
    @unit_price  = BigDecimal.new((row[:unit_price].to_f / 100).to_s)
    @created_at  = row[:created_at]
    @updated_at  = row[:updated_at]
    @item_id     = row[:item_id]
    @invoice_id  = row[:invoice_id]
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
