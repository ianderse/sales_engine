require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'

class SalesEngine

  attr_accessor :merchant_repository,
                :invoice_repository,
                :item_repository,
                :invoice_item_repository,
                :customer_repository,
                :transaction_repository,
                :dir

  def initialize(dir="data")
    @dir = dir
  end

  def startup
    merchants_csv = CsvHandler.new("./#{dir}/merchants.csv")
    @merchant_repository = MerchantRepository.new(self, merchants_csv.data)

    invoices_csv = CsvHandler.new("./#{dir}/invoices.csv")
    @invoice_repository  = InvoiceRepository.new(self, invoices_csv.data)

    items_csv = CsvHandler.new("./#{dir}/items.csv")
    @item_repository = ItemRepository.new(self, items_csv.data)

    invoice_item_csv = CsvHandler.new("./#{dir}/invoice_items.csv")
    @invoice_item_repository = InvoiceItemRepository.new(self, invoice_item_csv.data)

    customer_csv = CsvHandler.new("./#{dir}/customers.csv")
    @customer_repository = CustomerRepository.new(self, customer_csv.data)

    transaction_csv = CsvHandler.new("./#{dir}/transactions.csv")
    @transaction_repository = TransactionRepository.new(self, transaction_csv.data)
  end

  def find_items_by_merchant_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

  def find_invoices_by_customer_id(id)
    invoice_repository.find_all_by_customer_id(id)
  end

  def find_invoice_by_invoice_id(id)
    invoice_repository.find_by_id(id)
  end

  def find_invoice_item_by_invoice_id(id)
    invoice_item_repository.find_by_invoice_id(id)
  end

  def find_invoice_by_invoice_id(id)
    invoice_repository.find_by_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    invoice_item_repository.find_all_by_invoice_id(id)
  end

  def find_invoice_items_by_item_id(id)
    invoice_item_repository.find_all_by_item_id(id)
  end

  def find_item_by_item_id(id)
    item_repository.find_by_id(id)
  end

  def find_transactions_by_invoice_id(id)
    transaction_repository.find_all_by_invoice_id(id)
  end

  def find_customer_by_customer_id(id)
    customer_repository.find_by_id(id)
  end

  def find_merchant_by_merchant_id(id)
    merchant_repository.find_by_id(id)
  end

end

if __FILE__ == $0
  engine = SalesEngine.new
  engine.startup

  engine.merchant_repository
  engine.invoice_repository
  engine.item_repository
  engine.invoice_item_repo
  engine.customer_repository
  engine.transaction_repo
end
