require_relative 'lib/sales_engine'

jan = '2000-01-01 00:00:01 UTC'
feb = '2000-02-01 00:00:01 UTC'

invoice_items = [
  {id: 1, quantity: 5, created_at: jan},
  {id: 2, quantity: 1, created_at: jan},
  {id: 3, quantity: 5, created_at: jan},
  {id: 4, quantity: 5, created_at: feb},
  {id: 6, quantity: 1, created_at: feb},
]

InvoiceItemRepository.new("fake", invoice_items)
  .find_all_by_quantity(5)
  .find_all_by_created_at(jan)
  .each { |inv_item| puts inv_item.id }
