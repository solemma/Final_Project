require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'
enable :sessions
use Rack::Flash, :sweep=>true

set :database, "sqlite3:///new_project.sqlite3"

set :sessions, true

require './models'

# get'/sup' do 
# 	puts "THESE ARE MY PARAMS"
# 	puts params.inspect
# end

get '/' do
	# User.create(fname: "Sos")
	erb :home
	# puts fname 
end

get '/profile' do
	erb :profile
end




post '/sign-in' do
	@user=User.where(username: params[:username]).first
	if @user && @user.password==params[:password]
		flash[:notice]="You've Successfully Signed In"
		redirect "/profile"
	else
		flash[:notice]="Username/Password Combination Incorrect"
		redirect "/"
		erb :sign_in
		erb :layout
	end
end

	#This is for once a user has been successfully signed-In

	# def current_user
	# 	if session[:user_id]
	# 		@current_user=User.find(session[:user_id])
	# 	end
	# end


	# @user=User.last
	# session[:user_id]=@user.id



#User.create