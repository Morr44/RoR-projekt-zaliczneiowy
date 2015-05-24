class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_attached_file :attachment, styles: { small: "64x64", med: "100x100", large: "200x200" }, :default_url => "/missing_resource.txt"
  validates_attachment_content_type :attachment, :content_type => [
    
    "image/jpg",
    "image/jpeg",
    "image/png",
    "image/gif",
    "application/vnd.ms-excel",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    "application/msword",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
    "text/plain" 
  ]
  
  validates :title, presence: true
  validates :description, presence: true
  validates :priority, presence: true
  
  enum status: [:open, :closed, :cancelled,]
  
  def delete_attachment
    self.attachment.destroy
    self.attachment.clear
    self.attachment_name = nil;
  end
  
  def attach
    if(self.attachment.exists?)
      @attach = "1"
    else
      @attach = "0"
    end
  end


  
end
