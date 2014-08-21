class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :repo

  # row implies knowledge of CSV persistence
  # but this object should be correct independent of context
  def initialize(row, repo)
    @id          = row[:id]
    @first_name  = row[:first_name]
    @last_name   = row[:last_name]
    @created_at  = row[:created_at]
    @updated_at  = row[:updated_at]
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
