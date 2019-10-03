FactoryBot.define do
  factory :invoice do |fac|
    status { 'shipped' }
    fac.association :customer
    fac.association :merchant
  end
end
