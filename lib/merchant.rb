require_relative 'date_handler'

class Merchant
  attr_reader :id, :name, :created_at, :updated_at, :repo

  def initialize(params, repo)
    @id          = params[:id].to_i
    @name        = params[:name]
    @created_at  = DateHandler.new(params[:created_at]).to_date
    @updated_at  = DateHandler.new(params[:updated_at]).to_date
    @repo        = repo
  end

  def items
    repo.find_items_by_merchant_id(self.id)
  end

  def invoices
    repo.find_invoices_by_merchant_id(self.id)
  end

  def successful_invoices
    invoices.find_all {|invoice| invoice.successful_transaction?}
  end

  def grouped_customers
    successful_invoices.group_by {|invoice| invoice.customer.last_name}
  end

  def favorite_customer
    grouped_customers.sort[0].last[0].customer
  end

  def failed_invoices
    invoices.select {|invoice| !invoice.successful_transaction?}
  end

  def customers_with_pending_invoices
    failed_customers = failed_invoices.map do |invoice|
      invoice.customer
    end
    failed_customers.uniq
  end

  def revenue(date=nil)
    if date.nil?
      total_revenue
    else
      revenue_on_date(date)
    end
  end

  def total_revenue
    successful_invoices.reduce(0) {|s, invoice| s + invoice.revenue}
  end

  def invoices_on_date(date)
    successful_invoices.find_all do |invoice|
      if created_at_date?(invoice, date) || updated_at_date?(invoice, date)
        invoice
      end
    end
  end

  def revenue_on_date(date)
    invoices_on_date(date).reduce(0) {|t, i| t + i.revenue}
  end

  def created_at_date?(invoice, date)
    invoice.created_at == date

  end

  def updated_at_date?(invoice, date)
    invoice.updated_at == date
  end

  def items_sold
    successful_invoices.reduce(0) {|s, invoice| s + invoice.invoice_items.size}
  end

end

