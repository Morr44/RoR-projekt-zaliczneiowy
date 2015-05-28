class AddReportedToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :reported, :boolean

  end
end
