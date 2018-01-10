class CreateComputeds < ActiveRecord::Migration
  def change
    create_table :computeds do |t|
      t.references :test, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
