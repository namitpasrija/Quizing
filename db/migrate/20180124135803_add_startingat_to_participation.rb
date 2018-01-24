class AddStartingatToParticipation < ActiveRecord::Migration
  def change
  	add_column :participations, :startingat, :datetime
  end
end
