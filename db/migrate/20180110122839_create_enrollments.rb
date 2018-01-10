class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :test, index: true, foreign_key: true
      t.datetime :startedAt
      t.datetime :endsAt
      t.boolean :submittedStatus
      t.integer :wrongAnswers
      t.integer :correctAnswers
      t.integer :score
      t.integer :maxscore

      t.timestamps null: false
    end
  end
end
