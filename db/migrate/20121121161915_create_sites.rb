class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :description
      t.string :hostname
      t.string :layout
      t.integer :user_id

      t.timestamps
    end
	add_index :sites, [:user_id, :created_at]
  end
end
