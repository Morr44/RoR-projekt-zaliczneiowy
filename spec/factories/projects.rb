require 'faker'

FactoryGirl.define do
    factory :project do |f|
        sequence(:name) { |n| "Project #{n} name" }
        f.description {Faker::Lorem.sentence}
    end
    
    factory :invalid_project, parent: :project do |f|
        f.name nil 
    end
    
end

