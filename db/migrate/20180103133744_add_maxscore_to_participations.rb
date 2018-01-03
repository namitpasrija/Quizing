class AddMaxscoreToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :maxscore, :integer
  end
end
