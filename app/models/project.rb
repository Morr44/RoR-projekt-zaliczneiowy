class Project < ActiveRecord::Base
    has_many :tickets, dependent: :destroy
    has_and_belongs_to_many :users
    validates :name, presence: true
    
end
