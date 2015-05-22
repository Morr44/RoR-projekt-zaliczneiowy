class AddProductOwner < ActiveRecord::Migration
  def change
    add_column :projects, :owner_id, :string, references: :users
  end
end
