class AddQuenoToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :queno, :number
  end
end
