FactoryBot.define do
  factory :item do |fac|
    sequence :name {|n| "Item #{n}" }
    description { 'Description' }
    unit_price { 20.99 }
    fac.association :merchant
  end
end
