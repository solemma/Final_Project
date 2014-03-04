class CreateUsersTable < ActiveRecord::Migration
  def change
  	  	  	create_table :users do |t|
  		t.string :email
  		t.string :fname
  		t.string :lname
  		t.string :username
  		t.string :password
  		t.datetime :birthday
  	end
  end
end
