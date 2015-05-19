class Ticket < ActiveRecord::Base
  belongs_to :project
  
  validates :title, presence: true
  validates :description, presence: true
  validates :priority, presence: true
  
  enum status: [:open, :closed, :cancelled,]
  
end
