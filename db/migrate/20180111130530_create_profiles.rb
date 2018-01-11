class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :gender
      t.datetime :dob
      t.text :country
      t.text :facebook
      t.text :linkedin
      t.text :twitter
      t.text :snapchat
      t.text :interests
 	  t.text :about
 	  t.text :profession
 	  t.text :profession_place

      t.timestamps null: false
    end
  end
end
