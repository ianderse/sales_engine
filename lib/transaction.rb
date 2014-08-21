class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration, :result, :created_at, :updated_at, :repo

  def initialize(row, repo)
    @id          = row[:id]
    @invoice_id  = row[:invoice_id]
    @credit_card_number      = row[:credit_card_number]
    @credit_card_expiration  = row[:credit_card_expiration]
    @result      = row[:result]
    @created_at  = row[:created_at]
    @updated_at  = row[:updated_at]
    @repo = repo
  end

  def invoice
    repo.find_invoice_by_invoice_id(self.invoice_id)
  end

  def successful_transaction?
    result == 'success'
  end

end
