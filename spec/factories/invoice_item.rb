FactoryBot.define do
  factory :invoice_item do |fac|
    quantity { 2 }
    unit_price { 2.25 }
    fac.association :invoice
    fac.association :item
  end
end
