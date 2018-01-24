class AddEndingatToParticipation < ActiveRecord::Migration
  def change
  	add_column :participations, :endingat, :datetime
  end
end
