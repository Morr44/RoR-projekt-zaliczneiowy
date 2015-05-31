require 'faker'

FactoryGirl.define do
    factory :project do |f|
        sequence(:name) { |n| "Project #{n} name" }
        f.description {Faker::Lorem.sentence}
    end


    
end

