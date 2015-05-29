class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         

  validates_confirmation_of :password
  validates :password, { confirmation: true } 
  
  has_and_belongs_to_many :projects
  has_many :tickets
  
  def get_description
    [self.first_name, self.last_name, self.email].join(" ")
  end
  
  
end
