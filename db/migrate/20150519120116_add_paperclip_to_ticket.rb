class AddPaperclipToTicket < ActiveRecord::Migration
  def change
    add_attachment :tickets, :attachment  
  end
end