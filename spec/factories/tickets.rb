require 'faker'

FactoryGirl.define do
  
  factory :ticket do
    sequence(:title) { |n| "ticket #{n} title" }
    description {Faker::Lorem.sentence}
    priority {Faker::Number.number(1)}
    estimation {Faker::Number.number(2)}
    status "open"
    
    attachment_name {Faker::Lorem.word}
    attachment { fixture_file_upload(Rails.root.join('spec', 'appendages', 'valid.png'), 'image/png') }
    
  end
  
  
end