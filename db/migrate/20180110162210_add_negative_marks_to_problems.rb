class AddNegativeMarksToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :negativemarks, :integer
  end
end
