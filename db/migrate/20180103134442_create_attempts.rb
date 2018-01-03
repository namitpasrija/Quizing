class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :test, index: true, foreign_key: true
      t.references :problem, index: true, foreign_key: true
      t.string :answered
      t.integer :status
      t.integer :marks

      t.timestamps null: false
    end
  end
end
