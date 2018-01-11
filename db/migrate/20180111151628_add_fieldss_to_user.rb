class AddFieldssToUser < ActiveRecord::Migration
  def change
    add_column :users, :country, :text
    add_column :users, :profession, :text
    add_column :users, :profession_place, :text
    add_column :users, :facebook, :text
    add_column :users, :linkedin, :text
    add_column :users, :twitter, :text
    add_column :users, :interests, :text
    add_column :users, :about, :text
  end
end
