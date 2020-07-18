FactoryBot.define do
  factory :category do
    name { 'Salary' }
    flow { :income }
  end
end

