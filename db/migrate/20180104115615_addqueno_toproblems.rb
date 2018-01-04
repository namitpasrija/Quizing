class AddquenoToproblems < ActiveRecord::Migration
  def change
    add_column :problems, :queno, :integer
  end
end
