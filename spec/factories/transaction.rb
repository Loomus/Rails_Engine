FactoryBot.define do
  factory :transaction do |fac|
    credit_card_number { '4234409408246213'}
    result { 'success' }
    fac.association :invoice
  end
end
