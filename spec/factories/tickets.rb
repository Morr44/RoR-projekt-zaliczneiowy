require 'faker'

FactoryGirl.define do
  
  factory :ticket do
    sequence(:title) { |n| "ticket #{n} title" }
    description {Faker::Lorem.sentence}
    priority {Faker::Number.number(1)}
    estimation {Faker::Number.number(2)}
    status rand(0..2)
    
  end
end