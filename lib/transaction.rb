require_relative 'date_handler'

class Transaction
  attr_reader :id,
              :invoice_id,
              :cc_number,
              :cc_expiration,
              :result,
              :created_at,
              :updated_at,
              :repo

  def initialize(params, repo)
    @id          = params[:id].to_i
    @invoice_id  = params[:invoice_id].to_i
    @cc_number      = params[:credit_card_number]
    @cc_expiration  = params[:credit_card_expiration]
    @result      = params[:result]
    #change this using .to_date
    @created_at  = DateHandler.new(params[:created_at]).to_date
    @updated_at  = DateHandler.new(params[:updated_at]).to_date
    @repo = repo
  end

  def invoice
    repo.find_invoice_by_invoice_id(self.invoice_id)
  end

  def successful_transaction?
    result == 'success'
  end

end
