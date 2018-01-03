class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :test, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :score
      t.integer :wrongAnswers
      t.integer :correctAnswers

      t.timestamps null: false
    end
  end
end
