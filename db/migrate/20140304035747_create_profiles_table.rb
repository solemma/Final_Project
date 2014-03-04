class CreateProfilesTable < ActiveRecord::Migration
  def change
  	  	create_table :profiles do |t|
  		t.integer :user_id
  		t.string :interests
  		t.string :city
  		t.string :school
  	end
  end
end
