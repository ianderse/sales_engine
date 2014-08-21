class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration, :result, :created_at, :updated_at, :repo

  def initialize(params, repo)
    @id          = params[:id].to_i
    @invoice_id  = params[:invoice_id].to_i
    @credit_card_number      = params[:credit_card_number].to_i
    @credit_card_expiration  = params[:credit_card_expiration]
    @result      = params[:result]
    #change this using .to_date
    @created_at  = params[:created_at]
    @updated_at  = params[:updated_at]
    @repo = repo
  end

  def invoice
    repo.find_invoice_by_invoice_id(self.invoice_id)
  end

  def successful_transaction?
    result == 'success'
  end

end
