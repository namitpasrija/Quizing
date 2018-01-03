class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.text :title
      t.text :description
      t.integer :duration
      t.datetime :startTime
      t.datetime :endTime
      t.text :conductedBy
      t.references :user, index: true, foreign_key: true
      t.integer :fee
      t.text :prize
      t.text :instructions
      t.text :password
      t.text :tType

      t.timestamps null: false
    end
  end
end
