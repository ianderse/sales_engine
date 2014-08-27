require_relative 'date_handler'
class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :repo

  def initialize(params, repo)
    @id          = (params[:id]).to_i
    @first_name  = params[:first_name]
    @last_name   = params[:last_name]
    @created_at  = DateHandler.new(params[:created_at]).to_date
    @updated_at  = DateHandler.new(params[:updated_at]).to_date
    @repo = repo
  end

  def invoices
    repo.find_invoices_by_customer_id(self.id)
  end

  def transactions
    invoices.find_all {|invoice| invoice.transactions}
  end

  def successful_transactions
    transactions.find_all {|transaction| transaction.successful_transaction?}
  end

  def successful_invoices
    invoices.find_all {|invoice| invoice.successful_transaction?}
  end

  def favorite_merchant_id
    g = successful_transactions.group_by {|transaction| transaction.merchant_id}
    g.max_by {|transaction| transaction.size}[0]
  end

  def favorite_merchant
    repo.engine.merchant_repository.find_by_id(favorite_merchant_id)
  end

  def items_bought
    successful_invoices.reduce(0) {|s, invoice| s + invoice.total_item_quantity}
  end

  def revenue
    successful_invoices.reduce(0) {|s, invoice| s + invoice.revenue}
  end

  def days_since_activity
    Time.now.day - transactions.last.updated_at.day
  end

  def pending_invoices
    invoices.select {|invoice| !invoice.successful_transaction?}
  end

end
