require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'
enable :sessions
use Rack::Flash, :sweep=>true

configure (:development) {set :database, "sqlite:///blog.sqlite3"}
set :sessions, true

set :database, "sqlite3:///new_project.sqlite3"

require './models'

def current_user
	if session[:user_id]
		User.find(session[:user_id])
	else
		nil
	end
end


get '/' do
	@user=current_user
	erb :home
end

post '/sessions/new' do
end

post '/sign-in' do
	@user=User.where(username: params[:username]).first
	if @user && @user.password==params[:password]
		flash[:notice]="You've Successfully Signed In!"
		session[:user_id] = @user.id
		redirect "/profile"
	else
		flash[:notice]="Invalid username/Password combination, create a new account"
		redirect "/sign-up"
		erb :sign_up
		erb :layout
	end
end

get '/profile' do
	@user=current_user
	erb :profile
end

get '/sign-up' do
	erb :sign_up
end

post '/sign-up' do
	@newuser=User.create(params[:user])
	session[:user_id] = @newuser.id
	redirect '/create-profile'
end

get '/create-profile' do
	erb :create_profile
	@newuser=current_user
end

post '/create-profile' do
	@newprofile=Profile.new(params[:profile])
	@newprofile.user_id = session [:user_id]
	@newprofile.save
	redirect '/'
end

get '/create-post' do
	erb :create_post
end

post '/create-post' do
	@newpost=Post.new(params[:post])
	@newpost.user_id = current_user.id
	@newpost.save
	redirect '/profile'
end

get '/sign-out' do
	session[:user_id]=nil
end

get '/logout' do
	session[:user_id] = nil
	redirect '/'
end