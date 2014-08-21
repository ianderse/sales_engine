
class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :repo

  def initialize(params, repo)
    @id          = (params[:id]).to_i
    @first_name  = params[:first_name]
    @last_name   = params[:last_name]
    #to_date
    @created_at  = params[:created_at]
    @updated_at  = params[:updated_at]
    @repo = repo
  end

  def invoices
  	repo.find_invoices_by_customer_id(self.id)
  end

  def transactions
    invoices.find_all {|invoice| invoice.transactions}
  end

  def favorite_merchant
  end

end
