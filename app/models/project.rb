class Project < ActiveRecord::Base
    has_many :tickets, dependent: :destroy
    has_and_belongs_to_many :users
    belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
    
    validates :name, presence: true
    
    def set_owner(user)
        if self.users.include?(user)
            self.owner = user
        end
    end
    
    def add_associate(user)
        self.users << user
    end
    
end
