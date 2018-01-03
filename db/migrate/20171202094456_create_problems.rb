class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.text :que
      t.text :option1
      t.text :option2
      t.text :option3
      t.text :option4
      t.text :option5
      t.text :option5
      t.text :option6
      t.text :option7
      t.text :option8
      t.text :option9
      t.text :option10
      t.integer :testid
      t.text :subject
      t.integer :marks
      t.integer :diffLevel
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
