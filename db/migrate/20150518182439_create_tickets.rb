class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.integer :priority
      t.integer :estimation
      t.integer :status
      t.references :project, index: true

      t.timestamps
    end
  end
end
