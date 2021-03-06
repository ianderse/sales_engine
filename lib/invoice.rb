require_relative 'date_handler'
require_relative 'transaction'
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

  def total_item_quantity
    invoice_items.reduce(0) {|total, item| total + item.quantity}
  end

  def customer
    repo.find_customer_by_customer_id(self.customer_id)
  end

  def merchant
    repo.find_merchant_by_merchant_id(self.merchant_id)
  end

  def successful_transaction?
    transactions.any? {|transaction| transaction.successful_transaction?}
  end

  def successful_transactions
    transactions.find_all {|transaction| transaction.successful_transaction?}
  end

  def revenue
    invoice_items.reduce(0) {|s, invoice_item| s + invoice_item.item_revenue }
  end

  def items
    invoice_items.collect {|invoice_item| invoice_item.item }
  end

  def charge(params)
    cc_number     = params[:credit_card_number]
    cc_expiration = params[:credit_card_expiration]
    result        = params[:result]
    time          = Time.now
    created_at    = "#{time.year}-#{time.month}-#{time.day}"

    transactions.last.nil? ? t_id = 0 : t_id = transactions.last.id

    trans_repo = @repo.engine.transaction_repository
    params = {id: t_id + 1, invoice_id: self.id,
              credit_card_number: cc_number,
              credit_card_expiration: cc_expiration, result: result,
              created_at: created_at, updated_at: created_at}

    trans_repo.transactions << Transaction.new(params, self)
  end



end
