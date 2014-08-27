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

  def favorite_merchant_id
    g = successful_transactions.group_by {|transaction| transaction.merchant_id}
    g.max_by {|transaction| transaction.size}[0]
  end

  def favorite_merchant
    repo.engine.merchant_repository.find_by_id(favorite_merchant_id)
  end
end
