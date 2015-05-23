class AddUserIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :user_id, :string, references: :users
  end
end
