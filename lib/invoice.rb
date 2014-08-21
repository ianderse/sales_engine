require 'csv'

class Invoice

 attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :repo
 def initialize(row, repo)
 	  @id          = row[:id]
 	  @customer_id = row[:customer_id]
 	  @merchant_id = row[:merchant_id]
 	  @status      = row[:status]
 	  @created_at  = row[:created_at]
 	  @updated_at  = row[:updated_at]
    @repo        = repo
 	end

  def transactions
    repo.find_transactions_by_invoice_id(self.id)
  end

  def invoice_items
    repo.find_invoice_items_by_invoice_id(self.id)
  end

  def customer
    repo.find_customer_by_customer_id(self.customer_id)
  end

  def merchant
    repo.find_merchant_by_merchant_id(self.merchant_id)
  end

  def items
    invoice_items.collect do |invoice_item|
      invoice_item.item
    end
  end

  #validate data
end
