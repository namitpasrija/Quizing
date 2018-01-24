class AddColumnToAttempt < ActiveRecord::Migration
  def change
  	  add_column :attempts, :enrollmentendsat, :datetime
  end
end