class AddprofilePicUrlToUser < ActiveRecord::Migration
  def change
  	add_column :users, :profilePicUrl, :text
  end
end
