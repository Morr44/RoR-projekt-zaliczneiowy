class Project < ActiveRecord::Base
    has_many :tickets, dependent: :destroy
    has_and_belongs_to_many :users
    belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
    
    validates :name, presence: true
    
end
