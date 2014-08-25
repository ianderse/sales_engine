require_relative 'date_handler'
class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :repo

  def initialize(params, repo)
    @id          = (params[:id]).to_i
    @first_name  = params[:first_name]
    @last_name   = params[:last_name]
    #to_date
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

  def favorite_merchant
    succesful_transactions = transactions.each {|transaction| transaction.successful_transaction?}
    grouped_transactions   = succesful_transactions.group_by {|transaction| transaction.merchant_id}
    merchant_id = grouped_transactions.max_by {|transaction| transaction.size}[0]
    repo.engine.merchant_repository.find_by_id(merchant_id)
  end
end
