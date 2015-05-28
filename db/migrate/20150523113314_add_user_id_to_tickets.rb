class AddUserIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :user, :string, references: :users
  end
end
