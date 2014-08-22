require_relative 'date_handler'
class Invoice

 attr_reader :id,
             :customer_id,
             :merchant_id,
             :status,
             :created_at,
             :updated_at,
             :repo

 def initialize(params, repo)
    @id          = params[:id].to_i
    @customer_id = params[:customer_id].to_i
    @merchant_id = params[:merchant_id].to_i
    @status      = params[:status]
    #to_date
    @created_at  = DateHandler.new(params[:created_at]).to_date
    @updated_at  = DateHandler.new(params[:created_at]).to_date
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
