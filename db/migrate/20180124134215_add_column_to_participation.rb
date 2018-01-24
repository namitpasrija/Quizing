class AddColumnToParticipation < ActiveRecord::Migration
  def change
  	add_column :participations, :testTitle, :text
  end
end
