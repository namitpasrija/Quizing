class AddFieldsToUser < ActiveRecord::Migration
   def change
    add_column :users, :FirstName, :text
    add_column :users, :LastName, :text
    add_column :users, :Dob, :datetime
    add_column :users, :Gender, :text
    add_column :users, :Contact, :text
  end
end
