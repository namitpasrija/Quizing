class AdddobToUser < ActiveRecord::Migration
  def change
  	add_column :users, :bornon, :text
  end
end
